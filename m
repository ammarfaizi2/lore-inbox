Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281054AbRKDR1s>; Sun, 4 Nov 2001 12:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280970AbRKDR1i>; Sun, 4 Nov 2001 12:27:38 -0500
Received: from 10cust182.starstream.net ([63.205.212.182]:19866 "HELO
	10cust182.starstream.net") by vger.kernel.org with SMTP
	id <S280042AbRKDR11>; Sun, 4 Nov 2001 12:27:27 -0500
Date: Sun, 4 Nov 2001 09:27:21 -0800
From: Ted Deppner <ted@psyber.com>
To: jarboui@laas.fr
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression testing of 2.4.x before release?
Message-ID: <20011104092721.B16083@dondra.ofc.psyber.com>
Reply-To: Ted Deppner <ted@psyber.com>
In-Reply-To: <3BE4E835.CF85035B@kegel.com> <20011103231503.A16083@dondra.ofc.psyber.com> <3BE52ECB.DFE7B040@laas.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE52ECB.DFE7B040@laas.fr>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 01:04:27PM +0100, Tahar wrote:
> Just a newbie question: where can we find such stress tests, and what
> are the kernel parts targeted by these tests ?

A few searches for "linux benchmark", "unix benchmark", or perhaps just
"benchmark" on Google and Freshmeat.net should turn up plenty to keep you
busy.

Linus and others have said in the past thought, that YOUR usage is the
testing they want...  So it's best if you install the kernel and use it
normally, whatever you'd use a kernel to do.

I am concerned about lots of I/O and multiprocessing... So I test by doing
CD-RW burns to two drives (12x and a 4x), NFS data moves (using bonnie,
dd, and cat), while listening to MP3 streams, reading my email, and
watching extace, with some of my mysql data loading scripts running.

These are all things I do normally, and I'm the best able to compare new
performance to past performance.  Sure, I don't do all of those things all
at the same time _usually_, but that's the main body of my 'test bench'.

-- 
Ted Deppner
http://www.psyber.com/~ted/
