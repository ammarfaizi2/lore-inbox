Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUDPFQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 01:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUDPFQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 01:16:46 -0400
Received: from zeus.city.tvnet.hu ([195.38.100.182]:10880 "EHLO
	zeus.city.tvnet.hu") by vger.kernel.org with ESMTP id S262356AbUDPFQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 01:16:37 -0400
Subject: Re: off:latest binary nvidia driver won't compile with 2.6.6-rc1
From: Sipos Ferenc <sferi@mail.tvnet.hu>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040415212923.GA2656@mars.ravnborg.org>
References: <1082061685.5837.2.camel@zeus.city.tvnet.hu>
	 <20040415212923.GA2656@mars.ravnborg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082092808.2027.3.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Fri, 16 Apr 2004 07:20:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Something is wrong with your solution, because I'm building a monolithic
kernel, so nvidia would be my only module. I have done make modules as
you've said (I think a simple make does that also, so it wouldn't be
required), and the Modules.synvers file doesn't exist. 2.6.5 works
normally, only using nvidia as a module. Note that module support is
compiled in the kernel.

Paco

On cs, 2004-04-15 at 23:29 +0200, Sam Ravnborg wrote:
> On Thu, Apr 15, 2004 at 10:41:25PM +0200, Sipos Ferenc wrote:
> > Hi!
> > 
> > The outer module patch for .temp creation didn't solve the problem,
> > compilation stops with can't fine Modules.synver in /usr/src/linux-
> > 2.6.6-rc1.
> 
> You need to do a ' make modules' first, otherwise the Modules.symvers file
> will not be created.
> 
> 	Sam
