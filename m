Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291531AbSBSRco>; Tue, 19 Feb 2002 12:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291522AbSBSRcf>; Tue, 19 Feb 2002 12:32:35 -0500
Received: from 96dyn50.com21.casema.net ([62.234.27.50]:29636 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S291531AbSBSRcX>; Tue, 19 Feb 2002 12:32:23 -0500
Message-Id: <200202191732.SAA08008@cave.bitwizard.nl>
Subject: Re: secure erasure of files?
In-Reply-To: <20020219.HQ8.97132600@karlsbakk.net> from Roy Sigurd Karlsbakk
 at "Feb 19, 2002 02:48:45 pm"
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Date: Tue, 19 Feb 2002 18:32:17 +0100 (MET)
CC: Jens Schmidt <j.schmidt@paradise.net.nz>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> What is sure: Ibas does not know any documented methods, scientific
> environments or commercial services that do or demonstrate reading
> of overwritten data.

Ah. Our data-recovery competitor IBAS. Short addition: "Same here". 


Wietze Venema, (I'm sure you know what he's famous for) once had a
slide in his show that showed an image of magnetic track that had been
overwritten with new data. You could visually see that the head had
been mis-positioned by about 0.1 track-width, such that the old data
was still visible from below. This would lead you to believe that
possibly your old data could be retrieved. 

This is easier said than done. In this case they had been able to
image the patter at over 100 times more resolution than the magnetic
head of the drive. Imaging a whole 10G platter this way would yield
you a few terabytes of data, from which you can try to find the old
data back. Good luck.

Some success is rumored to be able to be achieved by sampling the
normal signal, and then subtracting the "expected signal assuming the
current sequence of bits that was read". That way you might be able to
recover the information that peeks out from below. On the other hand,
the electronics is ALREADY partly doing this to recover the normal
data that is read from the platter...

In practise all this doesn't work: The head will not be mispositioned
0.1 track to the same side during the whole revolution. Thus you will
have parts of the previous data generation peeking out on the left
side for part of the track and data from the generation before on the
other side. Which you will see is not predetermined.

Now, if there are military secrets on the drive, the opponent may want
to acutally go and image the platter, and reconstruct the data on a
bit by bit basis. If you then happen to stumble on just a couple of
"launch codes" or something like that, then "all hell breaks loose". 
Thus the chance that this might possibly happen is to be prevented. 


				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
