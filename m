Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVCQVxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVCQVxX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 16:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVCQVxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 16:53:21 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:55314 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261167AbVCQVwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 16:52:54 -0500
Date: Thu, 17 Mar 2005 22:56:14 +0100
To: regatta <regatta@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 32Bit vs 64Bit
Message-ID: <20050317215614.GA30388@hh.idb.hist.no>
References: <5a3ed5650503160744730b7db4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3ed5650503160744730b7db4@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 06:44:51PM +0300, regatta wrote:
> Hi everyone,
> 
> I have a question about the 64Bit mode in AMD 64bit
> 
> My question is if I run a 32Bit application in Optreon AMD 64Bit with
> Linux 64Bit does this give my any benefit ? I mean running 32Bit
> application in 64Bit machine with 64 Linux is it better that running
> it in 32Bit or doesn't make any different at all ?
> 
There are quite a few indirect benefits:

The kernel itself might be faster because it takes advantage
of extra registers and so on.  So the app might wait less on
its syscalls.

Also, this app may be 32-bit but surely a lot of other programs
will be available as 64-bit software and will be faster.  That
leaves more time for running your 32-bit app.

Helge Hafting
