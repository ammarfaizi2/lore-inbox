Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130324AbQLHBvp>; Thu, 7 Dec 2000 20:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130067AbQLHBvf>; Thu, 7 Dec 2000 20:51:35 -0500
Received: from Cantor.suse.de ([194.112.123.193]:34067 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129967AbQLHBvS>;
	Thu, 7 Dec 2000 20:51:18 -0500
Date: Fri, 8 Dec 2000 02:20:44 +0100
From: Andi Kleen <ak@suse.de>
To: Rainer Mager <rmager@vgkk.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Signal 11
Message-ID: <20001208022044.A6417@gruyere.muc.suse.de>
In-Reply-To: <E144BOL-0003Eg-00@the-village.bc.nu> <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com>; from rmager@vgkk.com on Fri, Dec 08, 2000 at 09:44:29AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 09:44:29AM +0900, Rainer Mager wrote:
> 	I recently upgraded to a new machine. It is running RedHat 6.2 Linux (with
> a SMP 2.4.0test[8-11] kernel) and has a Matrox G400 in it. X is 4.0.1.
> Anyway, about once every 2-3 days X will spontaneously die and the only info
> I get back is that it was because of signal 11.
> 	I've heard that signal 11 can be related to bad hardware, most often
> memory, but I've done a good bit of testing on this and the system seems ok.
> What I did was to run the VA Linux Cerberos(sp?) test for 15 hours+ with no
> errors. Actually this only worked when running from the console. When
> running from X the machine locked up (although no signal 11).
> 	The only info I've gotten back from the XFree86 mailing lists so far is
> that there are known and wide spread problems with SMP and these types of
> problems. Can anyone comment on this? Are there known SMP problems? What is
> the current resolution plan?

signal 11 just means that the program crashed with a segmentation fault. 

Sounds like a X Server bug. You should probably contact XFree86, not
linux-kernel


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
