Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWEaVQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWEaVQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWEaVQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:16:41 -0400
Received: from ik55118.ikexpress.com ([213.246.55.118]:47496 "EHLO
	ik55118.ikexpress.com") by vger.kernel.org with ESMTP
	id S965084AbWEaVQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:16:40 -0400
Message-ID: <447E07A1.1030601@free-electrons.com>
Date: Wed, 31 May 2006 23:16:17 +0200
From: Michael Opdenacker <michael-lists@free-electrons.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: How to extract the cpio archive in the kernel image?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Does anyone know a simple, command line way to extract the cpio archive 
embedded in a (compressed) kernel image?

That would be useful to modify the initramfs included in the kernel 
image even if one only has the kernel binary and sources, but not the 
initramfs sources.

Of course, it is always possible to get the initramfs contents from the 
running kernel and dump them somewhere, or to write a custom program for 
this purpose (accessing and uncompressing the embedded cpio archive as 
the kernel does), but it would be nice it there was a simpler way with 
regular Unix commands (I guess involving gunzip and cpio).

In a nutshell, how to open the penguin and still get the golden egg? ;-)

    Cheers,

    Michael.  

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)

