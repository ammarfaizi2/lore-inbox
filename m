Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSESUdS>; Sun, 19 May 2002 16:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSESUdR>; Sun, 19 May 2002 16:33:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:14749 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315214AbSESUdQ>;
	Sun, 19 May 2002 16:33:16 -0400
Message-ID: <3CE809C0.59C4CBD5@gmx.de>
Date: Sun, 19 May 2002 22:23:28 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        rusty@rustcorp.com.au, alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <Pine.LNX.4.44.0205180910570.26742-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On 18 May 2002, Andi Kleen wrote:
> >
> > Are you sure they even exist ?
> 
> Oh, like read() or write() for regular files? Yup, they exist.

And that would be?  I've never seen such an abomination.  Sure,
mapping pages on SEGV is use, but passing only partially mapped
buffers to read/write on purpose???

Ciao, ET.
