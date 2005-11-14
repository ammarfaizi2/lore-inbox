Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVKNVPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVKNVPE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVKNVPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:15:04 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:42581 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932129AbVKNVPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:15:02 -0500
Message-ID: <4378FED8.2060505@tmr.com>
Date: Mon, 14 Nov 2005 16:17:12 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David.Ronis@mcgill.ca
CC: linux-kernel@vger.kernel.org
Subject: Re: Serious IDE problem still present in 2.6.14
References: <Pine.LNX.4.44.0510301030120.26176-100000@coffee.psychology.mcmaster.ca>	 <1130689871.6348.3.camel@montroll.chem.mcgill.ca>	 <4365511C.7040903@yahoo.de>	 <1130713716.6348.7.camel@montroll.chem.mcgill.ca>	 <4365596F.4060105@yahoo.de>	 <1130785344.5932.6.camel@montroll.chem.mcgill.ca>	 <43673DFE.4000702@yahoo.de>	 <1131022436.6016.4.camel@montroll.chem.mcgill.ca>	 <436A9C30.3080705@yahoo.de> <1131680793.6300.20.camel@montroll.chem.mcgill.ca>
In-Reply-To: <1131680793.6300.20.camel@montroll.chem.mcgill.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ronis wrote:
> I've been busy and have been a bit late responding to this.  In short,
> have a problem with disk performance on a HP Pavilion laptop in the
> 2.6.1[34] kernels (it works fine under 2.6.12.x).  I've summarized much
> of the tests I've run on in a post to linux-kernel and linux-ide (when
> we thought it was a problem in the ATIIXP module) at:
> 
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=112802950411697&w=2
> 
> After working with Stefan for a bit, we determined that the problem is
> in the ACPI modules (in fact setting ACPI=ht at boot fixes it, although
> other things seem to break, as described below).  Stefan suggested I
> repost the bug to the linux-kernel list, and so here it is.

Is this read performance, write performance, or both? And have you 
checked the output in dmesg? See anything with blockdev? Detailed lspci 
output and /proc/interrupts?

I don't have anything in mand, just looking for information which might 
in some universe get diddled by ACPI.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
