Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270841AbRHSWgW>; Sun, 19 Aug 2001 18:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270848AbRHSWgM>; Sun, 19 Aug 2001 18:36:12 -0400
Received: from unthought.net ([212.97.129.24]:2222 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S270841AbRHSWf6>;
	Sun, 19 Aug 2001 18:35:58 -0400
Date: Mon, 20 Aug 2001 00:36:12 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: David Ford <david@blue-labs.org>
Cc: otto.wyss@bluewin.ch,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why don't have bits the same rights as humans! (flushing to disk waiting  time)
Message-ID: <20010820003612.A29624@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	David Ford <david@blue-labs.org>, otto.wyss@bluewin.ch,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3B802B68.ADA545DB@bluewin.ch> <3B803AAD.4030505@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3B803AAD.4030505@blue-labs.org>; from david@blue-labs.org on Sun, Aug 19, 2001 at 06:16:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2001 at 06:16:13PM -0400, David Ford wrote:
> Mount your floppy synchronous.  Writes won't be buffered then.

Or use tar on /dev/fd0

Seriously - many people are not aware of that since they think of floppies
like filesystems.  But for many purposes tar is exactly what you want - and
then there's no mounting and un-mounting, no buffered writes, and it may
even work directly in your HP-UX box too    :)

If you absolutely must write to a FAT filesystem on the floppy, you can
use the mtools package (mcopy, mdir, mformat, ...) - again, you won't have to
mount or unmount, writes are not buffered, etc. etc.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
