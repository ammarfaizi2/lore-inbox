Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287307AbSBSStc>; Tue, 19 Feb 2002 13:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286942AbSBSStW>; Tue, 19 Feb 2002 13:49:22 -0500
Received: from 96dyn50.com21.casema.net ([62.234.27.50]:47045 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S287307AbSBSStE>; Tue, 19 Feb 2002 13:49:04 -0500
Message-Id: <200202191848.TAA08419@cave.bitwizard.nl>
Subject: Re: secure erasure of files?
In-Reply-To: <31030000.1014141568@flay> from "Martin J. Bligh" at "Feb 19, 2002
 09:59:28 am"
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Date: Tue, 19 Feb 2002 19:48:58 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Jens Schmidt <j.schmidt@paradise.net.nz>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> > Some success is rumored to be able to be achieved by sampling the
> > normal signal, and then subtracting the "expected signal assuming the
> > current sequence of bits that was read". That way you might be able to
> > recover the information that peeks out from below. 
> 
> It's more than rumour - I've seen this done. Dr Solomon's (whatever
> they called their data recovery branch), early 1990's, England.
> Maybe it was easier on older hardware like the MFM / RLL disks,
> and certainly easier to piece together fragmented data with earlier
> file formats.

Maybe the difference is in "what's the goal". For datarecovery we
don't really care about just a couple of bits here and there: We want
to piece together the whole thing. 

If you don't want a piece of your data getting into wrong hands
however, you'd better be safe than sorry.

So I (and the Ibas guy) are talking about practical recovery of a
useful amount of data, while even a couple of bits is in theory
dangerous if you really want it "gone".

> I believe the point of overwriting 3 times (or whatever) is to reduce
> the "subtracted difference" to noise levels where it's no longer useful.

Right. 

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
