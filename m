Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbTDKVRL (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTDKVRL (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:17:11 -0400
Received: from albireo.ucw.cz ([81.27.194.19]:55817 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261700AbTDKVRK (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 17:17:10 -0400
Date: Fri, 11 Apr 2003 23:28:50 +0200
From: Martin Mares <mj@ucw.cz>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net, message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411212850.GA13608@ucw.cz>
References: <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.33.0304111418320.14943-100000@router.windsormachine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0304111418320.14943-100000@router.windsormachine.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, world!\n

> Someone PLEASE tell me the simpler way to do this.

If you have an arbitrary system of splitters and you hook another 3-way
splitter to any of its outputs, you lose one output and gain 3 new
outputs, so the total number of outputs increases by 2. Hence if you
take K inputs and N 3-way splitters, the network has K+2N outputs,
no matter how the splitters are connected (of course unless you create
a cycle :-) ).

So in our case, we are searching for the smallest possible N such that
5+2N >= 4000, which equals ceil((4000-5)/2) = 1998.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
God is real, unless declared integer.
