Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUHaLOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUHaLOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 07:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUHaLOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 07:14:46 -0400
Received: from mp1-smtp-1.eutelia.it ([62.94.10.161]:32731 "EHLO
	smtp.eutelia.it") by vger.kernel.org with ESMTP id S267863AbUHaLOl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 07:14:41 -0400
Date: Tue, 31 Aug 2004 13:15:24 +0200
From: Luca Ferroni <fferroni@cs.unibo.it>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: linux-kernel@vger.kernel.org, miklos@szeredi.hu
Subject: Re: Userspace file systems
Message-Id: <20040831131524.6c26036d.fferroni@cs.unibo.it>
In-Reply-To: <20040831090158.GC14371@thundrix.ch>
References: <20040826044425.GL5414@waste.org>
	<1093496948.2748.69.camel@entropy>
	<20040826053200.GU31237@waste.org>
	<20040826075348.GT1284@nysv.org>
	<20040826163234.GA9047@delft.aura.cs.cmu.edu>
	<Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
	<20040831033950.GA32404@zero>
	<Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
	<413400B6.6040807@pobox.com>
	<20040831053055.GA8654@nietzsche.lynx.com>
	<20040831090158.GC14371@thundrix.ch>
Organization: Ferrlabs
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Tue, 31 Aug 2004 11:01:58 +0200,  Tonnerre <tonnerre@thundrix.ch> ha scritto:

> Uh, what about enhancing lufs code in this regard and porting all fs'es to it?
> 

I think that porting all file systems to LUFS is a mad idea :), 
but providing a facility in the kernel for user-space file system 
implementations could be great.

I am working on PackageFS (http://packagefs.sourceforge.net)
which is an user-space file system to manage packages:
it relies on LUFS, but I plan to port it soon to FUSE ( http://sourceforge.net/projects/avf)
that, at present, is maintained by Miklos Szeredi and works with latest kernels.

PackageFS relies also on existent package managers, it will be transparent to all
package formats. I. e.: you can install a package by copying, 
and see package informations by a simple cat.
Now it works only in Debian distro, and it is far from complete (it is 0.09 version :) ).

So, what do you think about including a kernel module to make a user able 
to develop, install and use an user-space file system ?

Maybe Miklos Szeredi will write more details about FUSE which is the interesting part
for kernel inclusion.

Bye
Luca

-- 
-----------------------------------------------
They'll never stole us our.... FREEDOM!!!
Luca Ferroni
ICQ #317977679
www.cs.unibo.it/~fferroni/
-----------------------------------------------
