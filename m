Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSAGXqr>; Mon, 7 Jan 2002 18:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287407AbSAGXqh>; Mon, 7 Jan 2002 18:46:37 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:36736 "HELO
	ohdarn.net") by vger.kernel.org with SMTP id <S287406AbSAGXq0>;
	Mon, 7 Jan 2002 18:46:26 -0500
Subject: Re: Second edition of the -mjc branch has been released
From: Michael Cohen <lkml@ohdarn.net>
To: linux-kernel@vger.kernel.org
Cc: pavel@suse.cz
In-Reply-To: <20020103203507.A408@elf.ucw.cz>
In-Reply-To: <200201030929.g039TCZ02342@ohdarn.net> 
	<20020103203507.A408@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Jan 2002 18:46:25 -0500
Message-Id: <1010447185.4069.2.camel@ohdarn.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-03 at 14:35, Pavel Machek wrote:
> Hi!
> 
> > removed in mjc2:
> > Software Suspend        (does not function correctly,
> >                          very poor style in some areas)
> 
> Which patch did you try to integrate? Can you elaborate on "does not
> function" and "poor style"? I want to see that fixed ;-).

There were a whole bunch of places where ifdefs were not inserted, and
the feature got turned on even if you didn't want it in some instances.
Also, well, it doesn't resume. ;)

-------
Michael Cohen

> 									Pavel
> -- 
> (about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
> no longer is classifiable as a democracy, but rather as a plutocracy." --hpa


