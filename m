Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbVINNUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbVINNUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVINNUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:20:47 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:39895 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S965201AbVINNUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:20:47 -0400
Date: Wed, 14 Sep 2005 09:20:45 -0400
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Joe Bob Spamtest <joebob@spamtest.viacore.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
Message-ID: <20050914132045.GS28551@csclub.uwaterloo.ca>
References: <4325F3D5.9040109@spamtest.viacore.net> <20050912.144107.37064900.davem@davemloft.net> <4325FADB.4090804@spamtest.viacore.net> <20050912.151230.100651236.davem@davemloft.net> <43260A8D.1090508@spamtest.viacore.net> <20050913165228.GG28578@csclub.uwaterloo.ca> <432705A0.1070407@spamtest.viacore.net> <5A770DA0-A30F-45B1-A47A-2FD21714FA3C@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A770DA0-A30F-45B1-A47A-2FD21714FA3C@mac.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 11:44:55PM -0400, Kyle Moffett wrote:
> PowerPC was designed 64-bit from the start too!  It's just that the  
> architecture design group also realized that there would be a demand  
> for 32-bit CPUs, and so from the _64-bit_ system, they designed a 32- 
> bit system whose entire instruction set would be forward-compatible  
> to 64-bit systems when they came out.  That's why 32-bit PowerPC  
> machine code and 64-bit PowerPC machine code are completely identical  
> except that 64-bit CPUs also have a few opcodes to process 64-bit  
> data and a few extra kernel-mode registers.

Hmm, so how does that fit with needing both 32 and 64bit libraries on a
ppc system?  It seems apple forgot the 64bit part of a library recently
in a security fix, or is that something more to do with their os than
the cpu?

Len Sorensen
