Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264375AbUFPSXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbUFPSXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUFPSXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:23:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61890 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264375AbUFPSVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:21:49 -0400
Date: Wed, 16 Jun 2004 11:15:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: ahu@ds9a.nl, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [DOCUMENTATION PATCH] Missing net sysctls, some fixed, rest
 flagged
Message-Id: <20040616111531.6047bb40.davem@redhat.com>
In-Reply-To: <40D006BF.7020002@cosmosbay.com>
References: <20040609175242.GA13875@outpost.ds9a.nl>
	<20040615201912.691ffe35.davem@redhat.com>
	<40D006BF.7020002@cosmosbay.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004 10:37:19 +0200
Eric Dumazet <dada1@cosmosbay.com> wrote:

> I dont agree with the 'TCP' word here : listen() system call is not tied 
> with TCP, isn't it ?
> I would suggest :
> 
> +somaxconn - INTEGER
> +	Limit of socket listen() backlog, known in userspace as SOMAXCONN.
> +	Defaults to 128. See also tcp_max_syn_backlog for additional tuning for TCP sockets.
> +

Works for me.  Applied.
