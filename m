Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132502AbRDNRzU>; Sat, 14 Apr 2001 13:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbRDNRzK>; Sat, 14 Apr 2001 13:55:10 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:20230 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132502AbRDNRyz>;
	Sat, 14 Apr 2001 13:54:55 -0400
Date: Sat, 14 Apr 2001 13:56:18 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: CML2 1.1.0 bug and snailspeed
Message-ID: <20010414135618.C10538@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Anton Altaparmakov <aia21@cus.cam.ac.uk>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <002601c0c4fb$c7e54260$0201a8c0@home> <Pine.SOL.3.96.1010414174944.810A-100000@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.3.96.1010414174944.810A-100000@libra.cus.cam.ac.uk>; from aia21@cus.cam.ac.uk on Sat, Apr 14, 2001 at 06:38:25PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cus.cam.ac.uk>:
> In the menu the colour scheme is a bit strange but everyone has a
> different taste. Would need some getting used to, but ok. It does seem
> like a step back in time though, compared to the old menuconfig which had
> nice windows feel and colours, IMHO. I am not sure why it had to be
> changed. Surely you can have the old interface with the new theorem
> prover?

I couldn't do both that and share back-end code with the other interfaces.
 
> I found a bug: In "Intel and compatible 80x86 processor options", "Intel
> and compatible 80x86 processor types" I press "y" on "Pentium Classic"
> option and it activates Penitum-III as well as Pentium Classic options at
> the same time!?! Tried to play around switching to something else and then
> onto Pentium Classic again and it enabled Pentium Classic and Pentium
> Pro/Celeron/Pentium II (NEW) this time! Something is very wrong here.

Rules file bug, probably.  I'll investigate this afternoon.

> Now a general comment: CML2 is extremely slow to the point of not being
> usable! )-:

I'm still tuning.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Love your country, but never trust its government.
	-- Robert A. Heinlein.
