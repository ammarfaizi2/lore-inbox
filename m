Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268300AbUIKU0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268300AbUIKU0H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUIKU0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:26:07 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:32935 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268300AbUIKUZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 16:25:52 -0400
Date: Sat, 11 Sep 2004 22:25:48 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: displaying kbuild dependancies ...
Message-ID: <20040911202548.GA31680@MAIL.13thfloor.at>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sam!

first, thanks for the kbuild stuff and all the 
time spent on that ... I really love it


from time to time I encounter some issue which
usually keeps me busy for a while, and I think
there probably is a simpler solution to that ...

the procedure:

I'm configuring a 2.6.X-rcY-bkZ kernel for testing
with QEMU, which in my setup basically requires
some QEMU specific settings, I usually turn on/off
by just editing the .config file by hand, and then
invoking 'make oldconfig' ...

to keep the possibility for error low, I usually
just remove the entries in question, and oldconfig
will ask me the relevant question, leading to a
nice config adapted to my purposes ...

the issue:

sometimes a dependancy doesn't allow me to remove
a config option, I absolutely have to remove for
my setup, like the VGA_CONSOLE, and then the hunt
for the option 'requiring' that one unconditinally
beginns ...

usually I start with grep and end with trial and
error, until I find the malicious dependancy ...

so, now the question:

is there a magic option, simple procedure, or just
quick and dirty hack to get a list or some kind 
of dependancy graph from the kbuild system?

TIA,
Herbert


