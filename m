Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTLOSnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbTLOSnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:43:50 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:63762 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S264252AbTLOSnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:43:49 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI Express support for 2.4 kernel 
In-reply-to: Your message of "Mon, 15 Dec 2003 13:35:40 CDT."
             <Pine.LNX.4.53.0312151328240.14863@chaos> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Dec 2003 05:43:38 +1100
Message-ID: <6906.1071513818@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 13:35:40 -0500 (EST), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>Well, it seems I am NOT denying reality. Others have just
>parroted the contents of an ELF __Header__. I will show you the
>actual allocation data.

Sigh.  You are demonstrating gcc 3.2, others are demonstrating gcc 3.3.
The latter will optimize an assigment to 0 and automatically move the
variable from data to bss.

