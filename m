Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWEWOjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWEWOjD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWEWOjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:39:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751344AbWEWOi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:38:58 -0400
Date: Tue, 23 May 2006 07:38:51 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Herman Elfrink <herman.elfrink@ti-wmc.nl>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FLAME: external kernel module for L2.5 meshing
Message-ID: <20060523073851.39c3b5fe@localhost.localdomain>
In-Reply-To: <44731733.7000204@ti-wmc.nl>
References: <44731733.7000204@ti-wmc.nl>
X-Mailer: Sylpheed-Claws 2.1.1 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O
> Usage
> =====
> - Load module:
>     modprobe flame [debuglevel=]  [flm_topo_timer=]
>       : debug level, default: 1
>       : topology check timer (in seconds), default: 5
> - Open/close a device with:
>     echo "up   []" > /proc/net/flame/cmd
>     echo "down " > /proc/net/flame/cmd
>       : name of FLAME device, e.g. flm0
>       : comma-separated list of MAC devices (at least one) that are
>       used below the FLAME device. All of these must be up.
>     : comma-separated list of MAC addresses of devices
>       for which traffic should be ignored; each MAC address should
>       be a semicolon-separated list of 6 hex-pairs
> - Get current forwarding info from FLAME:
>     cat /proc/net/flame/fwd
> - Get nodes/cost information from MACINFO:
>     cat /proc/net/macinfo


Use of /proc for an API is no longer desirable. Please rewrite.
