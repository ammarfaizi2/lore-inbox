Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268344AbUIKVjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268344AbUIKVjY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 17:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUIKVjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 17:39:24 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:15659 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268337AbUIKVjP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 17:39:15 -0400
Date: Sat, 11 Sep 2004 23:39:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: displaying kbuild dependancies ...
Message-ID: <20040911213931.GA22403@mars.ravnborg.org>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
References: <20040911202548.GA31680@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911202548.GA31680@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 10:25:48PM +0200, Herbert Poetzl wrote:
> 
> Hi Sam!
> 
> first, thanks for the kbuild stuff and all the 
> time spent on that ... I really love it
> 
> 
> from time to time I encounter some issue which
> usually keeps me busy for a while, and I think
> there probably is a simpler solution to that ...
> 
> the procedure:
> 
> I'm configuring a 2.6.X-rcY-bkZ kernel for testing
> with QEMU, which in my setup basically requires
> some QEMU specific settings, I usually turn on/off
> by just editing the .config file by hand, and then
> invoking 'make oldconfig' ...
> 
> to keep the possibility for error low, I usually
> just remove the entries in question, and oldconfig
> will ask me the relevant question, leading to a
> nice config adapted to my purposes ...
> 
> the issue:
> 
> sometimes a dependancy doesn't allow me to remove
> a config option, I absolutely have to remove for
> my setup, like the VGA_CONSOLE, and then the hunt
> for the option 'requiring' that one unconditinally
> beginns ...
> 
> usually I start with grep and end with trial and
> error, until I find the malicious dependancy ...

The only option today is to turn on the debug option
in 'make xconfig'.

I have been looking inot something better for menuconfig
but frankly kconfig is not where I feel most comfortable.

	Sam
