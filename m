Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSFIPTX>; Sun, 9 Jun 2002 11:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317626AbSFIPTW>; Sun, 9 Jun 2002 11:19:22 -0400
Received: from 54.61.26.24.cfl.rr.com ([24.26.61.54]:60933 "HELO
	potatoho.dyndns.org") by vger.kernel.org with SMTP
	id <S317623AbSFIPTV>; Sun, 9 Jun 2002 11:19:21 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Chris Faherty <rallymonkey@bellsouth.net>
To: Brad Hards <bhards@bigpond.net.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Logitech Mouseman Dual Optical defaults to 400cpi
Date: Sun, 9 Jun 2002 11:19:56 -0400
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020608165243Z317422-22020+923@vger.kernel.org> <20020609002448Z317485-22020+1014@vger.kernel.org> <200206091807.11524.bhards@bigpond.net.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020609151922Z317623-22020+1197@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 June 2002 04:07 am, Brad Hards wrote:

> Was that using Snoopy?

I believe that's what it was called.  The program was sniffusb 0.13.  I had 
problems get later versions to work.  Then I found a nice treatise on 
interpreting the log:

http://www.toth.demon.co.uk/usb/reverse-0.2.txt

> Any objections to me taking this to 2.4 and 2.5?

Feel free.  I wonder if MS Intellimouse 3.0 has the same resolution problem. 
AFAIK they use the same sensor.

> This could have been handled by a blacklist table quirk. Any reason why
> you chose to do it this way?

How does the blacklist work?  Originally I wanted to put the setting in 
mousedev but I wasn't sure how to access the usb_device from there.

-- 
/* Chris Faherty <rallymonkey@bellsouth.net> */
