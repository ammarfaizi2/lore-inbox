Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288974AbSAUAC6>; Sun, 20 Jan 2002 19:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288976AbSAUACt>; Sun, 20 Jan 2002 19:02:49 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:39429 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S288974AbSAUACd> convert rfc822-to-8bit; Sun, 20 Jan 2002 19:02:33 -0500
X-Envelope-From: martin.macok@underground.cz
Date: Mon, 21 Jan 2002 01:02:31 +0100
From: =?iso-8859-2?Q?Martin_Ma=E8ok?= <martin.macok@underground.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler updates, -J2
Message-ID: <20020121010231.A15740@sarah.kolej.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201181710520.10122-100000@localhost.localdomain> <20020119221928.A2042@sackman.co.uk> <20020120230102.A7373@sackman.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020120230102.A7373@sackman.co.uk>; from matthew@sackman.co.uk on Sun, Jan 20, 2002 at 11:01:04PM +0000
X-Echelon: GRU NSA GCHQ CIA Pentagon nuclear conspiration war teror anthrax
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 11:01:04PM +0000, Matthew Sackman wrote:
> > >     http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-J2.patch
> 
> One other thing that I've noticed, switching virtual workspaces will
> reliably cause xmms to stutter. If you switch rapidly then it is
> exacerbated.

And without sched O(1) it isn't ?

This doesn't have to be the scheduler problem, but a problem somewhere
else (low latency (?)).

For me it doesn't skip even under heavy disk (IDE), VM and cpu load
while while switching 1280x1024 workspaces really fast and for a long
time
[Athlon 850, Matrox G450, XF4.1, Window Maker]

(I use it with rmap11c + mini-ll + ah-IDE ... = -jl-11-mini + 18pre3)

-- 
         Martin Maèok                 http://underground.cz/
   martin.macok@underground.cz        http://Xtrmntr.org/ORBman/
