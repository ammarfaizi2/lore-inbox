Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291893AbSBIAT3>; Fri, 8 Feb 2002 19:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287872AbSBIATU>; Fri, 8 Feb 2002 19:19:20 -0500
Received: from blackhole.compendium-tech.com ([64.156.208.74]:19090 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S291890AbSBIATK>; Fri, 8 Feb 2002 19:19:10 -0500
Date: Fri, 8 Feb 2002 16:19:08 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
X-X-Sender: kernel@sol.compendium-tech.com
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <20020114131050.E14747@thyrsus.com>
Message-ID: <Pine.LNX.4.44.0202081612430.29874-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bothers me. I prefer building a monolithic kernel with only a few 
drivers compiled as modules (e.g. those drivers which are under active 
development and are upgraded often). I believe firmly that certain drivers 
should be part of the monolithic kernel.... either way, i'm not about to 
debate it. i'd just like to know exactly why this is being done, and to 
lodge an objection against it.

On Mon, 14 Jan 2002, Eric S. Raymond wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > For 2.5 if things go to plan there will be no such thing as a "compiled in"
> > driver. They simply are not needed with initramfs holding what were once the
> > "compiled in" modules.
> 
> This is something of a bombshell.  Not necessarily a bad one, but...
> 
> Alan, do you have *any* *freakin'* *idea* how much more complicated
> the CML2 deduction engine had to be because the basic logical entity
> was a tristate rather than a bool?  If this plan goes through, I'm
> going to be able to drop out at least 20% of the code, with most of
> that 20% being in the nasty complicated bits where the maintainability
> improvement will be greatest.  And I can get rid of the nasty "vitality"
> flag, which probably the worst wart on the language.
> 
> Yowza...so how soon is this supposed to happen?
> 

-- 
 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

