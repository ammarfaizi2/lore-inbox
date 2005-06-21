Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVFURx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVFURx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVFURx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:53:56 -0400
Received: from mail.dvmed.net ([216.237.124.58]:26792 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262211AbVFURxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:53:52 -0400
Message-ID: <42B8542A.9020700@pobox.com>
Date: Tue, 21 Jun 2005 13:53:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
References: <Pine.LNX.4.58.0506211304320.2915@skynet> <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org> <42B838BC.8090601@pobox.com> <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org> <42B84E20.7010100@pobox.com> <Pine.LNX.4.58.0506211039350.2268@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506211039350.2268@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Actually, I'd suggest doing the git-checkout-script _first_. That way you 
> _can_ use the careful version, which refuses to switch if it would cause 
> information to be lost. Ie something like
> 
> 	git-checkout-script $1 && switch HEAD to refs/heads/$1
> 
> should do it.


If I want my working dir updated to reflect the desired branch -- the 
whole purpose of git-switch-tree -- I would have to do

	git-checkout-script && switch HEAD && git-checkout-script

which is a bit silly.

	Jeff


