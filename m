Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264780AbRFSUza>; Tue, 19 Jun 2001 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264783AbRFSUzU>; Tue, 19 Jun 2001 16:55:20 -0400
Received: from richard2.pil.net ([207.8.164.9]:63246 "HELO richard2.pil.net")
	by vger.kernel.org with SMTP id <S264780AbRFSUzE>;
	Tue, 19 Jun 2001 16:55:04 -0400
Date: Tue, 19 Jun 2001 16:55:10 -0400 (EDT)
From: Tom Diehl <tdiehl@pil.net>
X-X-Sender: <tdiehl@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: How to compile on one machine and install on another?
In-Reply-To: <E15CSDK-0006ee-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106191646330.17727-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001, Alan Cox wrote:

> Other than making sure you configure it for the box it will eventually run
> on - nope you have it all sorted. If you use modules you'll want to install
> the modules on the target machine too

What is the best way to install the modules? Is there a directory _all_ of
the modules exist in b4 you do "make modules_install". I usually end up
setting EXTRAVERSION to something unique and doing a make modules_install.
That way it does not hose up the modules for the build machine.
Is there a better way?

-- 
......Tom		INCOMPETIANCE: When You Earnestly Believe You Can
tdiehl@pil.net		Compensate for a Lack of Skill by Doubling Your
			Efforts, There's No End to What You Can't Do.

