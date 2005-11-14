Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVKNVXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVKNVXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVKNVXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:23:04 -0500
Received: from torrent.cc.mcgill.ca ([132.206.27.49]:14215 "EHLO
	torrent.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id S932142AbVKNVXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:23:02 -0500
Subject: Re: Serious IDE problem still present in 2.6.14
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Reply-To: David.Ronis@mcgill.ca
To: Bill Davidsen <davidsen@tmr.com>
Cc: David.Ronis@mcgill.ca, linux-kernel@vger.kernel.org
In-Reply-To: <4378FED8.2060505@tmr.com>
References: <Pine.LNX.4.44.0510301030120.26176-100000@coffee.psychology.mcmaster.ca>
	 <1130689871.6348.3.camel@montroll.chem.mcgill.ca>
	 <4365511C.7040903@yahoo.de>
	 <1130713716.6348.7.camel@montroll.chem.mcgill.ca>
	 <4365596F.4060105@yahoo.de>
	 <1130785344.5932.6.camel@montroll.chem.mcgill.ca>
	 <43673DFE.4000702@yahoo.de>
	 <1131022436.6016.4.camel@montroll.chem.mcgill.ca>
	 <436A9C30.3080705@yahoo.de>
	 <1131680793.6300.20.camel@montroll.chem.mcgill.ca>
	 <4378FED8.2060505@tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Department of Chemistry, McGill University
Date: Mon, 14 Nov 2005 16:22:17 -0500
Message-Id: <1132003337.757.3.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply.  As per Andrew Morton's suggestion, I've opened a
bug at bugzilla.kernel.org
(http://bugzilla.kernel.org/show_bug.cgi?id=5594), it has all the
relevant information (basically copies of what I've posted on
linux-kernel and linux-ide).  So far it's still sitting there as "NEW".

David

On Mon, 2005-11-14 at 16:17 -0500, Bill Davidsen wrote:
> David Ronis wrote:
> > I've been busy and have been a bit late responding to this.  In short,
> > have a problem with disk performance on a HP Pavilion laptop in the
> > 2.6.1[34] kernels (it works fine under 2.6.12.x).  I've summarized much
> > of the tests I've run on in a post to linux-kernel and linux-ide (when
> > we thought it was a problem in the ATIIXP module) at:
> > 
> >    http://marc.theaimsgroup.com/?l=linux-kernel&m=112802950411697&w=2
> > 
> > After working with Stefan for a bit, we determined that the problem is
> > in the ACPI modules (in fact setting ACPI=ht at boot fixes it, although
> > other things seem to break, as described below).  Stefan suggested I
> > repost the bug to the linux-kernel list, and so here it is.
> 
> Is this read performance, write performance, or both? And have you 
> checked the output in dmesg? See anything with blockdev? Detailed lspci 
> output and /proc/interrupts?
> 
> I don't have anything in mand, just looking for information which might 
> in some universe get diddled by ACPI.

