Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbUJ0T7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbUJ0T7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbUJ0Tz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:55:26 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:6072 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S262605AbUJ0Tw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:52:57 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Paulo Marques <pmarques@grupopie.com>
Date: Wed, 27 Oct 2004 12:52:56 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Message-ID: <417F9A28.3690.3FE4ECFC@localhost>
In-reply-to: <417F8269.2070307@grupopie.com>
References: <417E9E3D.573.3C0CDE1A@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques <pmarques@grupopie.com> wrote:

> One other thing, is there a simple way to test the emulator? I've
> been careful with the changes I did not to change the resulting
> behaviour of the emulator, but I can not _absolutely_ sure that I
> didn't break anything. It would be very good to try the emulator
> in a controlled environment. 

Unfortunately the test code I wrote years ago is only for Open Watcom and 
uses inline assembler. It hasn't been used for some time and I am not 
sure if it works properly or not (I don't think it does right now). Plus 
we recently found out that it doesn't test everything, just the 
implementation of prim_ops.c.

The only real way to test the emulator is to use it to emulate some code. 
We don't have any code we use on a regular basis to test it, but perhaps 
we should think about building a test suite for it. Usually we test it on 
Video BIOS ROM's, but that is painful because you have to switch video 
cards all the time.

XFree86 and X.org do use the same code so it could be tested there, but 
once again it is only used for Video BIOS ROM stuff. 

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


