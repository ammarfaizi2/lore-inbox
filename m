Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVC2H1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVC2H1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbVC2HZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:25:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:13721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262488AbVC2HJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:09:52 -0500
Date: Mon, 28 Mar 2005 23:09:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, netdev@oss.sgi.com
Subject: Re: [PATCH] s390: qeth tcp segmentation offload
Message-Id: <20050328230929.639e51f3.akpm@osdl.org>
In-Reply-To: <4248FD8D.6030208@pobox.com>
References: <200503290533.j2T5X0ZZ028790@hera.kernel.org>
	<4248FD8D.6030208@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Please help me understand:  why add all this TSO code (zerocopy), if you 
>  are adding memcpy() under the hood?
> 
>  Was this reviewed on netdev?  or by any network developer?
> 
>  Overall this patch adds a whole lot of code that must be VERY intimate 
>  with the net stack, a huge maintenance burden that is likely to be rife 
>  with out-of-date code and bugs over time.
> 

There was some dicussion on linux-net last Thursday.
