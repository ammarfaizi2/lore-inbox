Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288184AbSAHRLs>; Tue, 8 Jan 2002 12:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288185AbSAHRLh>; Tue, 8 Jan 2002 12:11:37 -0500
Received: from mxzilla4.xs4all.nl ([194.109.6.48]:54544 "EHLO
	mxzilla4.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288184AbSAHRL1>; Tue, 8 Jan 2002 12:11:27 -0500
Date: Tue, 8 Jan 2002 18:11:21 +0100
From: jtv <jtv@xs4all.nl>
To: Anthony DeRobertis <asd@suespammers.org>
Cc: Jacques Gelinas <jack@solucorp.qc.ca>, linux-kernel@vger.kernel.org
Subject: Re: Whizzy New Feature: Paged segmented memory
Message-ID: <20020108181121.A12696@xs4all.nl>
In-Reply-To: <20020107224525.8a899969dbcd@remtk.solucorp.qc.ca> <BD98BECA-0407-11D6-804A-00039355CFA6@suespammers.org> <20020108122225.B11855@xs4all.nl> <E16NwsH-0005Ud-00@asd.ppp0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16NwsH-0005Ud-00@asd.ppp0.com>; from asd@suespammers.org on Tue, Jan 08, 2002 at 02:05:09PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 02:05:09PM +0000, Anthony DeRobertis wrote:
> 
> Change gcc. Recompile world. All should work, assuming your gcc changes are 
> bug-free, no one made assumptions about stack layout, no one wrote assembly 
> code, etc. [In other words, after 4 months of debugging you might get X 
> running again...] 
 
And, of course, the same for all other software.  But for a highly secure
project, for instance, that might be worth it.


> Some architectures have hardware assistance for downward growing stacks. One 
> example is 68K. I think x86 does too. OTOH, I don't think PPC does, though I 
> haven't read the Green Book recently. 

68K has predecrement/postincrement addressing modes (I'm not sure that
counts as "forcing" the stack to grow downwards); PPC has a symmetrical
load/store-with-update IIRC.


Jeroen

