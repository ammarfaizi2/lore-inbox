Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbQLOK7f>; Fri, 15 Dec 2000 05:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLOK7Z>; Fri, 15 Dec 2000 05:59:25 -0500
Received: from [194.213.32.137] ([194.213.32.137]:6916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129436AbQLOK7W>;
	Fri, 15 Dec 2000 05:59:22 -0500
Message-ID: <20001214204237.A468@bug.ucw.cz>
Date: Thu, 14 Dec 2000 20:42:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Chris Lattner <sabre@nondot.org>, "Mohammad A. Haque" <mhaque@haque.net>
Cc: Ben Ford <ben@kalifornia.com>, linux-kernel@vger.kernel.org,
        orbit-list@gnome.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <3A31BC6D.1CFB5221@haque.net> <Pine.LNX.4.21.0012121719180.20891-100000@www.nondot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0012121719180.20891-100000@www.nondot.org>; from Chris Lattner on Tue, Dec 12, 2000 at 05:26:26PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It was just an example. Basically, you'd be able to do in with just
> > about any language that has ORBit bindings.
> > 
> > Ben Ford wrote:
> > > Why would you *ever* want to write a device driver in perl???
> > 
> 
> Precisely... but also, there could be a case where perl would make
> sense.  Consider an FTP filesystem.  There performance is not dictated by
> the speed of the language, it's limited by bandwidth.  It could make sense
> to write your almighty FTPfs like this:
> 
> 1. Prototype it in Perl, get all the bugs out.
> 2. Rewrite in C in userspace, get all the bugs out.
> 3. recompile/relink in kernel space with no source modifications
> 4. ship product.  :)

Bad example, as (with codafs), you can do this safely & nicely without
korbit. See http://uservfs.sourceforge.net/
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
