Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319060AbSIJHVt>; Tue, 10 Sep 2002 03:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319065AbSIJHVt>; Tue, 10 Sep 2002 03:21:49 -0400
Received: from users.linvision.com ([62.58.92.114]:59028 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S319060AbSIJHVs>; Tue, 10 Sep 2002 03:21:48 -0400
Date: Tue, 10 Sep 2002 09:25:45 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Suparna Bhattacharya <suparna@in.ibm.com>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
Message-ID: <20020910092545.A21776@bitwizard.nl>
References: <3D77A58F.B35779A1@zip.com.au> <Pine.LNX.4.33.0209051155091.1307-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209051155091.1307-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 12:03:30PM -0700, Linus Torvalds wrote:
> 
> On Thu, 5 Sep 2002, Andrew Morton wrote:
> >
> > It would be simpler if it was nr_of_pages_completed.
> 
> Well.. Maybe.

Ehmm. I'm in the data-recovery business, and we seem to have lost
the ability to recover the other 3k of a 4k page if one of the blocks 
is bad. 

And we're annoyed about the read-ahead trying to read blocks past
a bad block without returning to the application. 

			Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
