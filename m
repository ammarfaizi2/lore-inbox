Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbTF0XOB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 19:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTF0XOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 19:14:01 -0400
Received: from cmu-24-35-32-166.mivlmd.cablespeed.com ([24.35.32.166]:1284
	"EHLO lap.molina") by vger.kernel.org with ESMTP id S264929AbTF0XN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 19:13:58 -0400
Date: Fri, 27 Jun 2003 19:26:14 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: "P. Christeas" <p_christ@hol.gr>
cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Synaptics support kills my mouse
In-Reply-To: <200306261746.14578.p_christ@hol.gr>
Message-ID: <Pine.LNX.4.44.0306271925370.881-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003, P. Christeas wrote:

> It is true, 2.5.73 unconditionally detects and tries to use the Syn. Touchpad 
> in 'absolute mode'. I wouldn't blame the authors of the module, however. They 
> are already doing a great job :).
> 
> I 've read the code to see what's wrong and found that the problem is that the 
> Touchpad itself doesn't report any data to the PS/2 port. The code still 
> looks conforming to the specs.
> However, you shouldn't give up 2.5.73 because of that. You can still use the 
> PS/2 compatibility mode
>  o Compile the ps mouse as a module "psmouse"
>  o Arrange so that the module is loaded with the option "psmouse_noext=1"
>  o Have gpm and X (you can even use both of them) read /dev/input/mice as an 
> exps2 or imps2 mouse (Intellimouse Explorer PS/2) .

It is an ugly workaround, but it works.  Thanks.

