Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRALP05>; Fri, 12 Jan 2001 10:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbRALP0q>; Fri, 12 Jan 2001 10:26:46 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:11917 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129733AbRALP0m>; Fri, 12 Jan 2001 10:26:42 -0500
Date: Fri, 12 Jan 2001 17:25:45 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: khttpd beaten by boa
Message-ID: <20010112172545.H10035@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.21.0101071655090.1110-100000@home.lameter.com> <m14H4Nl-000OY9C@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <m14H4Nl-000OY9C@amadeus.home.nl>; from arjan@fenrus.demon.nl on Fri, Jan 12, 2001 at 02:36:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 02:36:41PM +0100, Arjan van de Ven wrote:
> > This just goes on to show that khttpd is unnecessary kernel bloat and can be
> > "just as well" handled by a userspace application, minus some rather very
> > special cases which do not justify its inclusion into the main kernel.
> Regarding wether either khttpd or TuX should be in the kernel: I take it
> that it is your oppinion that neither should be in the kernel. I disagree
> with that and I think having a http-server-engine  (or even a more generic
> file-serving engine) in the kernel can make sense for high-end uses. The
> average desktop-user doesn't profit from it, sure. But that also holds for
> things like hardware-raid or even SCSI. We still want those in though.

This thingie is nice for embedded use, where you need a webserver
for some stuff, but don't wan't to include one, because you need
it only to represent some machine values of a process
computer[1].

But we need a more generic one, which has the functionality of a
read only entry of /proc.

That would be _very_ useful.

Regards

Ingo Oeser

[1] Don't know the right translation for "Prozessrechner", Sorry ;-(
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
