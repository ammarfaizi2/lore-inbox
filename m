Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265561AbTFMWFv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 18:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265563AbTFMWFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 18:05:51 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:46823 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S265561AbTFMWFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 18:05:38 -0400
Date: Fri, 13 Jun 2003 23:19:22 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: OverrideX <overridex@punkass.com>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 hangs on boot
Message-ID: <20030613221922.GA11121@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Vojtech Pavlik <vojtech@ucw.cz>, OverrideX <overridex@punkass.com>,
	vojtech@suse.cz, linux-kernel@vger.kernel.org
References: <1055466518.29294.10.camel@nazgul> <20030613214944.GA10406@suse.de> <20030614001209.E10851@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030614001209.E10851@ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 12:12:09AM +0200, Vojtech Pavlik wrote:

 > > This really wants fixing badly. The source of this problem seems to be
 > > people taking 2.4 configs (where CONFIG_INPUT=m was fine), and it all
 > > going pear-shaped when people make oldconfig.  I'm aware of the problems
 > > that oldconfig can't override variables set in .config, so how about 
 > > just renaming CONFIG_INPUT to something else ?
 > 
 > I'm considering CONFIG_INPUT_ADVANCED, which would default to 'n', like
 > with the font and parition config and if set to 'n', all the modules
 > needed for 2.4 functional compatibility would be automatically built in.
 > What do you think?

I don't see how this helps the situation. CONFIG_INPUT=m from a 2.4
config will still make CONFIG_VT not show up in the 2.5 config.

		Dave

