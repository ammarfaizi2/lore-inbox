Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130251AbQLRLPn>; Mon, 18 Dec 2000 06:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131102AbQLRLPd>; Mon, 18 Dec 2000 06:15:33 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:26890 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S130251AbQLRLPS> convert rfc822-to-8bit;
	Mon, 18 Dec 2000 06:15:18 -0500
Date: Mon, 18 Dec 2000 02:44:45 -0800 (PST)
From: Chris Mason <mason@suse.com>
To: Henrik Størner <henrik@storner.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test12: innd bug came back?
In-Reply-To: <91jc2l$7tn$1@osiris.storner.dk>
Message-ID: <Pine.LNX.4.10.10012180138520.30931-100000@home.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 17 Dec 2000, Henrik [ISO-8859-1] Størner wrote:

> In <Pine.GSO.4.21.0012171626000.20573-100000@weyl.math.psu.edu> Alexander Viro <viro@math.psu.edu> writes:
> 
> >On Sun, 17 Dec 2000, Jorg de Jong wrote:
> 
> >> > >On 13 Dec 2000, Henrik [ISO-8859-1] Størner wrote:
> >> > >
> >> > >> Just to add a "me too" on this. I didn't report when I saw it last week
> 
> >> I'd like to second that. ME TOO !
> >> Since I switched to 2.4.0.test12 I again have the innd bug.
> >> ( well at least the same symptoms !)
> 
> >Guys, what blocksize are you using?
> 
> I am using Reiserfs, and I hear it has some problems with the changes
> introduced in pre12. So I will report back once the Reiserfs guys get 
> this settled.

Ok, the reiserfs patches for test12 are on ftp.reiserfs.org/pub/2.4/beta,
please let me know if they work for you.

I just reran the test case on test12, with tails on and off and got the
correct results.  There might be some interaction with the new O_SYNC code
I'm missing that is causing innd problems though (reiserfs still isn't
using the new sync stuff, workin on it).

-chris


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
