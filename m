Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269756AbRHMDJT>; Sun, 12 Aug 2001 23:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269760AbRHMDJK>; Sun, 12 Aug 2001 23:09:10 -0400
Received: from cr545978-a.nmkt1.on.wave.home.com ([24.112.25.43]:30985 "HELO
	saturn.tlug.org") by vger.kernel.org with SMTP id <S269756AbRHMDJF>;
	Sun, 12 Aug 2001 23:09:05 -0400
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
From: Mike Frisch <mfrisch@saturn.tlug.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3B772126.F23DB1D7@randomlogic.com>
In-Reply-To: <20010812155520.A935@ulthar.internal.mclure.org>
	<Pine.LNX.4.33.0108121557060.2102-100000@penguin.transmeta.com>
	<20010812161544.A947@ulthar.internal.mclure.org> 
	<3B772126.F23DB1D7@randomlogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 12 Aug 2001 23:08:38 -0400
Message-Id: <997672119.956.3.camel@frisch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Aug 2001 17:36:54 -0700, Paul G. Allen wrote:
> Call me dumb, but what was wrong with the SB Live! code in the 2.4.7
> trees? Mine works fine and has since I first installed RH 7.1 on this
> system. The only problem I had was when I compiled it into the kernel
> (instead of compiling as a module), sound would not work and I could not
> configure it with sndconfig.

While the SB Live! code seemed to work flawlessly on my Intel BX board,
since moving to the A7A266 (ALi MaGiK based), I am pretty much convinced
it has been the cause of my intermittent lockup problems.  Without the
emu10k1 driver loaded, I cannot get the machine to lockup and everytime
it has locked up the sound card has been in use.

Right now, I am running the ALSA driver (as somebody else had
mentioned), but not enough yet to know if it's going to cause a problem.

Mike.

