Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUIPMQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUIPMQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUIPMQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 08:16:35 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:53675 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S268019AbUIPMP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 08:15:28 -0400
Date: Thu, 16 Sep 2004 22:15:22 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <m3hdpyy9x3.fsf@averell.firstfloor.org>
Message-Id: <Pine.LNX.4.58.0409162209450.26494@fb07-calculator.math.uni-giessen.de>
References: <2EWxl-7CI-13@gated-at.bofh.it> <m3hdpyy9x3.fsf@averell.firstfloor.org>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Andi Kleen (AK) wrote:

AK> Sergei Haller <Sergei.Haller@math.uni-giessen.de> writes:
AK> 
AK> > the problem is that about 512 MB of that memory is lost (AGP aperture and 
AK> > stuff). Although everything is perfect otherwise.
AK> > As far as I understand, all the PCI/AGP hardware uses the top end of the 
AK> > 4GB address range to access their memory and there is just an 
AK> > "overlapping" of the addresses. thus only the remaining 3.5 GB are 
AK> > available.
AK> 
AK> It's a BIOS issue. Nothing the kernel can do about it. You are 
AK> talking to the wrong people.

Hi Andi,

I am sure you did read the rest of my mail, didn't you? I mean the part 
where I describe that there is an option in the BIOS for that but the 
kernel crashes if I enable it.

If it is still a problem of the BIOS, could you please be more specific 
about what exactly is the problem with the BIOS?


Thanks,
        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
