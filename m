Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264149AbTDWReK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTDWReK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:34:10 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:4564 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264169AbTDWRdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:33:18 -0400
Subject: Re: [Bug 623] New: Volume not remembered.
From: Disconnect <lkml@sigkill.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1527920000.1051118798@flay>
References: <21660000.1051114998@[10.10.2.4]>
	 <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay>
	 <20030423172120.GA12497@citd.de> <3EA6947D.9080106@suwalski.net>
	 <1527920000.1051118798@flay>
Content-Type: text/plain
Organization: 
Message-Id: <1051119922.16492.50.camel@sparky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Apr 2003 13:45:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 13:26, Martin J. Bligh wrote:
> I agree it's a disto problem to save and restore.
> 
> But I fail to understand how the distro can magically set a sensible 
> default, and yet we're unable to do so inside the kernel ? Setting it
> to something like 10 (or other very quiet setting) would seem reasonable.
> Then at least the poor user would have a clue what the problem was.
> 
> As to "There was little coherance between the various soundcards", yes
> this probably needs to be a per-soundcard setting for sensible defaults.
> I presume this is what the distros do?
> 
> Defaulting to silence seems user-malevolent ... 

The key there is -save- and restore.  The script defaults to "don't
touch" until it has a saved setting to use, which it can get either from
some user-triggered method or from a clean shutdown..

That, AFAIR, is also at least vaguely how that other desktop OS tends to
work - on shutdown save the settings, on boot restore them...

-- 
Disconnect <lkml@sigkill.net>

