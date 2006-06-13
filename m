Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWFMO6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWFMO6U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 10:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWFMO6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 10:58:20 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:23184 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751133AbWFMO6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 10:58:19 -0400
Date: Tue, 13 Jun 2006 16:58:15 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sridhar Samudrala <sri@us.ibm.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
In-Reply-To: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0606131657050.14789@yvahk01.tjqt.qr>
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+extern int kernel_ioctl(struct socket *sock, int cmd, unsigned long arg);
>+

I would prefer naming it kernel_sock_ioctl, since (general) ioctl often 
done on fds (or struct file * for that matter) rather than sockets.



Jan Engelhardt
-- 
