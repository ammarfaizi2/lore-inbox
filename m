Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTCEFcA>; Wed, 5 Mar 2003 00:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTCEFcA>; Wed, 5 Mar 2003 00:32:00 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:49157 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261868AbTCEFb4>;
	Wed, 5 Mar 2003 00:31:56 -0500
Date: Wed, 5 Mar 2003 06:42:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.63] aha152x, module issues
Message-ID: <20030305054223.GA1228@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Sam Ravnborg <sam@ravnborg.org>, Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030304204328.GA7271@mars.ravnborg.org> <Pine.LNX.4.44.0303041527020.23375-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303041527020.23375-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 03:28:05PM -0600, Kai Germaschewski wrote:

> Hmmh, interesting. The patch looks good to me, but there's still one thing 
> I don't understand: When compiling a module errors out, we should never 
> even go into the module postprocessing stage. Or were you running with -k?

What I did to provoke the error was the following:
0) Successfully compile of the tree
1) Edit dummy.c to provoke an error during compile time
2) Run make
	It errored out when compiling dummy.c
3) Ignored the error, and su to root
4) make modules_install

So no make -k, I was just trying to install the modules that succeded so far.

	Sam
