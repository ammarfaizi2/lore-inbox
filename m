Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVKJKBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVKJKBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 05:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVKJKBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 05:01:47 -0500
Received: from mail.dvmed.net ([216.237.124.58]:25068 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750745AbVKJKBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 05:01:47 -0500
Message-ID: <43731A82.90209@pobox.com>
Date: Thu, 10 Nov 2005 05:01:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: openat()
References: <43724AB3.40309@redhat.com> <Pine.LNX.4.63.0511091338200.728@twinlark.arctic.org> <4372F95E.3070107@pobox.com>
In-Reply-To: <4372F95E.3070107@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> I'm interested in openat(2) for the race-free implications.  I've been 
> working on a race-free coreutils replacement[1], targetted mainly at 

Whoops, the referenced [1] is:
http://www.kernel.org/pub/scm/linux/kernel/git/jgarzik/posixutils.git/

Key utils cp/mv/chmod remain unwritten, and rm needs to be updated per 
review from Al.  But it's a start...

	Jeff


