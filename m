Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUL1FRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUL1FRf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 00:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbUL1FRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 00:17:34 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:28073
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261162AbUL1FRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:17:33 -0500
Date: Mon, 27 Dec 2004 21:12:43 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: irda-users@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/irda/: misc possible cleanups
Message-Id: <20041227211243.7d05e891.davem@davemloft.net>
In-Reply-To: <20041215010528.GA12937@stusta.de>
References: <20041215010528.GA12937@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004 02:05:28 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below contains the following possible cleanups:
> - make some needlessly global code static
> - remove the following unused global functions:
>   - discovery.c: irlmp_find_device
>   - ircomm/ircomm_param.c: ircomm_param_flush
>   - irda_device.c: irda_device_set_dtr_rts
>   - irda_device.c: irda_device_change_speed
>   - irda_device.c: irda_device_set_mode
>   - iriap.c: iriap_getinfobasedetails_request
>   - iriap.c: iriap_getinfobasedetails_confirm
>   - iriap.c: iriap_getobjects_request
>   - iriap.c: iriap_getobjects_confirm
>   - iriap.c: iriap_getvalue
>   - irlan_client.c: irlan_client_reconnect_data_channel
>   - irlap_frame.c: irlap_send_frmr_frame
>   - irlmp.c: irlmp_status_request
> - remove the follwong unused global variables:
>   - irnet/irnet_ppp.c: irnet_ppp_ops
>   - irsysctl.c: sysctl_compression
> - qos.c: #ifndef CONFIG_IRDA_DYNAMIC_WINDOW irlap_requested_line_capacity

Looks good, applied.  Thanks Adrian.
