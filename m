Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWAaKj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWAaKj1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWAaKj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:39:26 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:14829 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750741AbWAaKj0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:39:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IaVsDer0foBozqrPa9cs6FsxlpzSbt9NT/uaLYm5FawiCShmFB9g2Y/mMQM3nZus2IA4wrbv+0+NijiyWL5jgcMNW1JHvdoQZ4pOuahInEdfRDMBb4u8Bclc6nQgLZdFI4xyXwyUndps4BeXvIoyN1KvL8bw6SYCFSxjUN1b5G0=
Message-ID: <f4fb6a4d0601310239o5cf95887y@mail.gmail.com>
Date: Tue, 31 Jan 2006 11:39:25 +0100
From: Massimo De Beni <maxdb82@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Make my own modules for kernel 2.4.32
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm a newbye to kernel 'modding' and I've a question that may seems
outdated... The situation is this:
I worked to get a Set Top Box to work with the latest stable 2.4
kernel, the way is clear but the box need some modules to be loaded at
boot in order to get the video and audio device to work (modules that
are not shipped in kernels 2.4...); now I'm building those modules
separatly, compiling directly the drivers source codes with 'make',
and then I insert the .o with 'insmod'.
I would create a better system in which one could compile those
modules directly on the 'make menuconfig' of the kernel, so I'm
modifying the various Makefiles && config files, but I'm a bit
confused... Any good hint?

Thanks in advance...!
