Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbUBYTp0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUBYTpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:45:25 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:30091 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S261275AbUBYTpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:45:21 -0500
Date: Wed, 25 Feb 2004 12:45:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: make help ARCH=xx fun
Message-ID: <20040225194520.GY1052@smtp.west.cox.net>
References: <m3y8qwv78e.fsf@lugabout.jhcloos.org> <20040222095021.GB2266@mars.ravnborg.org> <20040224215548.GF1052@smtp.west.cox.net> <20040225190049.GB2474@mars.ravnborg.org> <20040225180858.GW1052@smtp.west.cox.net> <20040225203927.GA2763@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225203927.GA2763@mars.ravnborg.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 09:39:27PM +0100, Sam Ravnborg wrote:

> > 
> > > I will try to come up with a patch the uses a file named
> > > arch/$(ARCH)/configs/index.txt
> > 
> > The 'issue' with configs/index.txt, I'll wager, is that for every new
> > board, that's one more file to modify (and thus possibly conflict on).
> 
> What about the following patch.
> This adds the support to the top-level Makefile, enabling this for all
> _defconfig users.
> I used 'printf' to get proper alignment. Otherwise arm for example
> looked really ugly.

Looks quite good, thanks.

> Is printf generally supported?

It's part of coreutils on debian (and shellutils on others), so I'll
wager a yes.

-- 
Tom Rini
http://gate.crashing.org/~trini/
