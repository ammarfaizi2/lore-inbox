Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270094AbTGUN2C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 09:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270103AbTGUN2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 09:28:01 -0400
Received: from netrealtor.ca ([216.209.85.42]:3082 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S270094AbTGUN17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 09:27:59 -0400
Date: Mon, 21 Jul 2003 09:42:47 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestion for a new system call: convert file handle to a cookie for transfering file handles between processes.
Message-ID: <20030721134247.GA14943@mark.mielke.cc>
References: <4cace4bf68.4bf684cace@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cace4bf68.4bf684cace@teleline.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 11:49:15AM +0200, RAMON_GARCIA_F wrote:
> Although it is posible to use unix sockets, my proposal
> integrates better with shell scripts.

How?

Whether you put magic into the kernel, or you build a user space server,
the interface can be the exact same. I don't buy the 'integrates better'
argument.

It looks like you want simpler code in user space, at the cost of
complicating the kernel, for a feature that will be not be used very
frequently at all. Is this not correct?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

