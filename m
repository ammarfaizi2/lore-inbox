Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWAVRvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWAVRvT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 12:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWAVRvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 12:51:19 -0500
Received: from kanga.kvack.org ([66.96.29.28]:12507 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751289AbWAVRvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 12:51:18 -0500
Date: Sun, 22 Jan 2006 12:47:07 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule SHAPER for removal
Message-ID: <20060122174707.GC1008@kvack.org>
References: <20060119021150.GC19398@stusta.de> <20060119215722.GO16285@kvack.org> <20060121004848.GM31803@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121004848.GM31803@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 01:48:48AM +0100, Adrian Bunk wrote:
> Do we really have to wait the three years between stable Debian releases 
> for removing an obsolete driver that has always been marked as 
> EXPERIMENTAL?
> 
> Please be serious.

I am completely serious.  The traditional cycle of obsolete code that works 
and is not causing a maintenence burden is 2 major releases -- one release 
during which the obsolete feature spews warnings on use, and another 
development cycle until it is actually removed.  That's at least 3 years, 
which is still pretty short compared to distro cycles.

There seems to be a lot of this disease of removing code for the sake of 
removal lately, and it's getting to the point of being really annoying.  If 
the maintainer of the code in question isn't pushing for its removal, I see 
no need to rush the process too much, especially when the affected users 
aren't even likely to see the feature being marked obsolete since they don't 
troll the source code looking for things that break setups.

		-ben
