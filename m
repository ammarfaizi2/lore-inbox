Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUCaL7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 06:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbUCaL7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 06:59:06 -0500
Received: from attila.bofh.it ([213.92.8.2]:10447 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S261918AbUCaL7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 06:59:03 -0500
Date: Wed, 31 Mar 2004 13:58:55 +0200
From: "Marco d'Itri" <md@Linux.IT>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Martin Schaffner <schaffner@gmx.li>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: booting 2.6.4 from OpenFirmware
Message-ID: <20040331115855.GB5228@wonderland.linux.it>
References: <321B041D-8298-11D8-AC61-0003931E0B62@gmx.li> <1080687527.1198.48.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080687527.1198.48.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 31, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > If I try to boot the stock kernel, OpenFirmware tells me "Claim 
> > failed", and returns to the command prompt.
> > 
> > Does anybody have an idea what is the cause of this?
> 
> That's strange, I do such netbooting everyday on a wide range of
> machines without trouble. Are you using some kind of cross compiler ?
> Maybe there are some issues with cross compiling of the boot wrapper...
I experienced the same problem (2.4.x kernels would boot from OF, 2.6.x
would not) on my B50 machines, I may even have discussed it with you on
IRC.
I did not try to debug this further and I started using yaboot.

-- 
ciao, |
Marco | [5461 tro7jFYIQ7uH6]
