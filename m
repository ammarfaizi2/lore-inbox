Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269785AbTGOWJW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269794AbTGOWJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:09:22 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:55790
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S269785AbTGOWJV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:09:21 -0400
Date: Wed, 16 Jul 2003 00:03:44 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: folkert@vanheusden.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: v2.6.0-test1 - no keyboard/mouse
Message-ID: <20030715220344.GD2684@wind.cocodriloo.com>
References: <200307152246.57389.folkert@vanheusden.com> <1058306246.584.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058306246.584.1.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 11:57:26PM +0200, Felipe Alfaro Solana wrote:
> On Tue, 2003-07-15 at 22:46, Folkert van Heusden wrote:
> > Ehrm, hello? Has this list became silent suddenly?
> > Anyway: I just tried 2.6.0-test1 on my celeron. Boots up flawlessly. Rather 
> > quick and all. X boots up, all fine.
> > Only one minor problem: the keyboard and the mouse do not work.
> > I *have* included input-core, etc.:
> > CONFIG_INPUT=y
> > CONFIG_INPUT_MOUSEDEV=y
> > CONFIG_INPUT_MOUSEDEV_PSAUX=y
> > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> > CONFIG_INPUT_EVDEV=y
> > CONFIG_INPUT_KEYBOARD=y
> > CONFIG_INPUT_MOUSE=y
> > CONFIG_INPUT_MISC=y
> > CONFIG_INPUT_PCSPKR=y
> > CONFIG_INPUT_UINPUT=y
> 
> I can't think of anything except CONFIG_VGA_CONSOLE. Is it set to "y"?

what about setting these usual switches to default "y"?
It would cut a lot of problems at the first encounters
with the latest kernel.

Greets, Antonio. 

--
In fact, this is all you need to know to be
a Caveman Database Programmer:

A relational database is a big spreadsheet
that several people can update simultaneously. 

