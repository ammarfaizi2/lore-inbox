Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281329AbRKTTy4>; Tue, 20 Nov 2001 14:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281308AbRKTTys>; Tue, 20 Nov 2001 14:54:48 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:25081 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281311AbRKTTyd>;
	Tue, 20 Nov 2001 14:54:33 -0500
Date: Tue, 20 Nov 2001 12:53:41 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Samuli Suonpaa <suonpaa@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15pre7: kernel: invalidate: busy buffer
Message-ID: <20011120125341.Y1308@lynx.no>
Mail-Followup-To: Samuli Suonpaa <suonpaa@iki.fi>,
	linux-kernel@vger.kernel.org
In-Reply-To: <87itc5dysd.fsf@puck.erasmus.jurri.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <87itc5dysd.fsf@puck.erasmus.jurri.net>; from suonpaa@iki.fi on Tue, Nov 20, 2001 at 09:31:46PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20, 2001  21:31 +0200, Samuli Suonpaa wrote:
> Nov 20 21:20:27 oberon kernel: invalidate: busy buffer
> Nov 20 21:20:27 oberon last message repeated 55 times
> Nov 20 21:20:27 oberon kernel: invalidate: dirty buffer
> Nov 20 21:20:27 oberon kernel: invalidate: busy buffer
> Nov 20 21:20:27 oberon kernel: invalidate: dirty buffer
> Nov 20 21:20:27 oberon kernel: invalidate: busy buffer
> Nov 20 21:20:27 oberon kernel: invalidate: dirty buffer
> Nov 20 21:20:27 oberon kernel: invalidate: busy buffer
> 
> Since I do not know what this should tell me, I'd appreciate if
> somebody told me what this is all about. I can, of course, provide
> more information if necessary. But since I don't have a clue on what
> this would be related to (other that the printk seems to be in
> buffer.c) I have no idea of what information might be useful.

It means you are using LVM on a new kernel.  Some day, the LVM code
will be changed so it doesn't do that.  For now it is not a real
error, just a warning.  It doesn't cause any real problems.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

