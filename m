Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVDLKDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVDLKDx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVDLKDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:03:52 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:59595 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262092AbVDLKCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:02:25 -0400
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Petr Baudis <pasky@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Call to atention about using hash functions as content indexers
 (SCM saga)
References: <20050411224021.GA25106@larroy.com>
	<20050411225139.GA9145@pasky.ji.cz>
	<aec7e5c30504111623309582d5@mail.gmail.com>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 12 Apr 2005 11:02:10 +0100
In-Reply-To: <aec7e5c30504111623309582d5@mail.gmail.com> (Magnus Damm's
 message of "Tue, 12 Apr 2005 01:23:02 +0200")
Message-ID: <tnx1x9g8g9p.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus.damm@gmail.com> wrote:
> On 4/12/05, Petr Baudis <pasky@ucw.cz> wrote:
>
>> (iv) You fail to propose a better solution.
>
> I would feel safer with back end storage filenames based on email and
> mtime together with an optional hash lookup that turns collisions into
> worse performance. But that's just me.

Have a look at bazaar-ng (http://www.bazaar-ng.org/), they seem to do
this. I had a quick look at it and they also seem to store the full
files when they change (similar to git). It is also a bit ahead of git
(started earlier) and looks quite promising.

-- 
Catalin

