Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTDRQeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbTDRQeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:34:18 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:37126 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263125AbTDRQeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:34:17 -0400
Date: Fri, 18 Apr 2003 12:32:35 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: davidsen@tmr.com
cc: linux-kernel@vger.kernel.org
Subject: Re: RedHat 9 and 2.5.x support
In-Reply-To: <Pine.LNX.4.10.10304181142200.13892-100000@clements.sc.steeleye.com>
Message-ID: <Pine.LNX.4.10.10304181221030.13892-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Apr 2003, Paul Clements wrote:
> On Fri, 18 Apr 2003, Bill Davidsen wrote:
> > The last I looked modprobe.conf was a seriously deficient subset of
> > modules.conf, but I haven't d/l the latest version, so some of the
> > omissions may have been addressed. The major feature missing is (or was)
> > the lack of probe capability (and probeall). 
> 
> I think you can achieve the same outcome with a carefully crafted "install"
> command in modprobe.conf (granted it will be much more verbose than the
> equivalent "probe"). 

Actually, it's even easier than that...Rusty's included a script:

/sbin/generate-modprobe.conf

in the new modutils package that will convert modules.conf to modprobe.conf
automagically...

--
Paul

