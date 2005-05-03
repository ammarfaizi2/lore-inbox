Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVECQkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVECQkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVECQkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:40:51 -0400
Received: from animx.eu.org ([216.98.75.249]:13960 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261312AbVECQkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:40:45 -0400
Date: Tue, 3 May 2005 12:40:12 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Rick Warner <rick@microway.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zImage on 2.6?
Message-ID: <20050503164012.GE11937@animx.eu.org>
Mail-Followup-To: Rick Warner <rick@microway.com>,
	linux-kernel@vger.kernel.org
References: <20050503012951.GA10459@animx.eu.org> <200505031206.09245.rick@microway.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505031206.09245.rick@microway.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please keep me CCd

Rick Warner wrote:
> On Monday 02 May 2005 09:29 pm, Wakko Warner wrote:
> > Is it possible to use zImage on 2.6 kernels or is bzImage required?
> Why do you need the zImage anyway?  Maybe there is another way around the 
> problem you are having.  Can you post what you are trying to do (end goal) ?

This is a little project I'm doing to beable to load a system onto a hard
drive.  The linux system is short lived by design and will run out of a
tmpfs root populated by various tgz files found either on CDs or a USB
stick.

My goal (which I realize may not be achivable nor is it important in the
long run) is to get the kernel and the initrd onto a single floppy disk
(Currently, I'm ~80kb too large for this).

I decided (remembering 2.2 days and prior when zImage was normally used) to
try zImage to see what happened.  I was going to compare the size of the
resulting images.  That's when I hit the problem.

I understand that upx can compress the kernel better and I also remember
hearing about utilizing bzip2 as the compressor for the kernel and initrd
images.

As far as my question, it still stands.  Is bzImage required (i386/x86) for
a 2.6 kernel?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
