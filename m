Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbTIDPB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265019AbTIDPB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:01:59 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:41455
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S264987AbTIDPBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:01:55 -0400
Date: Thu, 4 Sep 2003 14:32:08 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Fruhwirth Clemens <clemens-dated-1063536166.2852@endorphin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030904123208.GF2359@wind.cocodriloo.com>
References: <20030904104245.GA1823@leto2.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904104245.GA1823@leto2.endorphin.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 12:42:45PM +0200, Fruhwirth Clemens wrote:
> Hi!
> 
> I recently posted a module for twofish which implements the algorithm in
> assembler (http://marc.theaimsgroup.com/?l=linux-kernel&m=106210815132365&w=2)
> 
> Unfortunately the assembler used is masm. I'd like to change that. Netwide
> Assembler (nasm) is the assembler of my choice since it focuses on
> portablity and has a more powerful macro facility (macros are heavily used
> by 2fish_86.asm). But as I'd like to make my work useful (aim for an
> inclusion in the kernel) I noticed that this would be the first module to
> depend on nasm. Everything else uses gas.
> 
> So the question is: Is a patch which depends on nasm likely to be merged?
> 
> For more information on "what is nasm":
> http://nasm.sourceforge.net/doc/html/nasmdoc1.html#section-1.1

nasm is i386-only.

gas is part of binutils and supports lots of target CPUs: I think the
first part of a new gcc architecture backend is the machines description
so that gas can assemble code for it.
 
Greets, Antonio.
