Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWEJTHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWEJTHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 15:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWEJTHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 15:07:39 -0400
Received: from depni.sinp.msu.ru ([213.131.7.21]:31646 "EHLO depni.sinp.msu.ru")
	by vger.kernel.org with ESMTP id S964831AbWEJTHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 15:07:38 -0400
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
	<1147257266.17886.3.camel@localhost.localdomain>
	<1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	<1147273787.17886.46.camel@localhost.localdomain>
	<1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	<Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com>
	<20060510162404.GR3570@stusta.de>
	<Pine.LNX.4.58.0605101240190.20305@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605101327380.20305@gandalf.stny.rr.com>
	<20060510112730.2f462289@localhost.localdomain>
From: Serge Belyshev <belyshev@depni.sinp.msu.ru>
Cc: linux-kernel@vger.kernel.org
Date: Wed, 10 May 2006 23:07:36 +0400
In-Reply-To: <20060510112730.2f462289@localhost.localdomain> (Stephen Hemminger's message of "Wed, 10 May 2006 11:27:30 -0700")
Message-ID: <87wtct7l6v.fsf@foo.vault.bofh.ru>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> writes:

> On Wed, 10 May 2006 13:45:58 -0400 (EDT)
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> 
>> Oh fsck! gcc is hosed. I just tried out this BS module:
>
> Read the GCC bug report.
> 	http://gcc.gnu.org/bugzilla/show_bug.cgi?id=5035
>
> It seems it is one of those "it too hard to fix, so we aren't going to"
> blow offs.

That bug report has nothing to do with the issue above. The correct
PR is: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=19430
