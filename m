Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263895AbSIQIfp>; Tue, 17 Sep 2002 04:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263910AbSIQIfp>; Tue, 17 Sep 2002 04:35:45 -0400
Received: from users.linvision.com ([62.58.92.114]:39067 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S263895AbSIQIfo>; Tue, 17 Sep 2002 04:35:44 -0400
Date: Tue, 17 Sep 2002 10:40:10 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: venom@sns.it, louie miranda <louie@chikka.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hi is this critical??
Message-ID: <20020917104010.A6175@bitwizard.nl>
References: <Pine.LNX.4.43.0209161537200.5180-100000@cibs9.sns.it> <1032184041.7199.14.camel@bip>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1032184041.7199.14.camel@bip>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 03:47:20PM +0200, Xavier Bestel wrote:
> Le lun 16/09/2002 à 15:37, venom@sns.it a écrit :
> > 
> > yes, this is critical.
> > It means that your HD is going to break soon.
> > 
> 
> Maybe these error messages should be a bit less cryptic for the
> uninitiated. Or is there a userspace utility to convert theses to
> luser-understandable messages ?

The problem is that you're going to leave out details to do this. 
This means that even the experts don't know what happened. 

>From the reported message I was able to pinpoint the exact spot on
his hdb2 partition where his drive has a bad spot, and I can calculate
the size of his hdb1 partition (In this case probably unneccesary
information, but still...). 

If the error message says something like: 

	"your harddrive hdb seems to be failing. Replace it NOW!"

then I can't make a valid decision about this. I have had a WD 31600
drive which had the trouble that the last 400M would go "bad": Lots of
bad blocks. In that situation I had to monitor the drive to just have
bad blocks in the last 400M or so, while I used only the first 1000M.
(Yes, only for "tmp" stuff.)

I also have a drive that has exactly ONE bad block. Run it through
"badblocks", and you can use the disk just fine. A read-ahead
might hit on the bad block, leading to funny error messages. However
I DO need to know which block.

MAC and Windows both try to give "simple" error messages. As a 
knowledgeable person I then am confronted with:

	"Something went wrong. Contact your sysadmin if you can't
	fix it yourself". 

Well, I -=AM=- the sysadmin, and would like to know what went wrong. 
Otherwise I can't fix it. This is NOT the way to go. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
