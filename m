Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161385AbWBUGKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161385AbWBUGKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161388AbWBUGKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:10:45 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:36881 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161385AbWBUGKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:10:44 -0500
Date: Tue, 21 Feb 2006 07:10:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] duplicate #include check for build system
Message-ID: <20060221061043.GA9279@mars.ravnborg.org>
References: <20060221014824.GA19998@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221014824.GA19998@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 02:48:24AM +0100, Herbert Poetzl wrote:
> 
> Hi Sam! Folks!
> 
> recently had the idea to utilize cpp or sparse to
> do some automated #include checking, and I came up
> with the following proof of concept:
Nice way - looks better than randomly parsing a lot of files.
 
> I just replaced the sparse binary by the following
> script (basically hijacking the make C=1 system)
Thats just fine. It is made general to support more than sparse if
feasible.
 
> of course, most of it would not be required if
> there was support in the kernel build system,
I do not see what you think could improve things on the kbuild side.
Please elaborate a bit more.

> and, if there is any preference for perl over
> bash/gawk it could be easily rewritten ...
For tools that is run only now and then you are fine to use perl if you
prefer. We have though until now avoided it as a strict dependency.
Also a few more comments would be nice so even I understand the script.

	Sam
