Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUKCPac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUKCPac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbUKCP1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:27:01 -0500
Received: from 200.80-202-166.nextgentel.com ([80.202.166.200]:39877 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261659AbUKCPZr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:25:47 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net>
	<20041103143348.GA24596@outpost.ds9a.nl>
	<yw1xis8nhtst.fsf@ford.inprovide.com>
	<20041103152531.GA22610@DervishD>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Wed, 03 Nov 2004 16:25:21 +0100
In-Reply-To: <20041103152531.GA22610@DervishD> (DervishD's message of "Wed,
 3 Nov 2004 16:25:31 +0100")
Message-ID: <yw1xbrefhs4e.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <lkml@dervishd.net> writes:

>     Hi all :)
>
>  * Måns Rullgård <mru@inprovide.com> dixit:
>> >> I'd tried to kill the zombie earlier but couldn't.
>> >> Isn't there some way to clean up a &^$#^#@)_ zombie?
>> > Kill the parent, is the only (portable) way.
>> Perhaps not as portable, but another possible, though slightly
>> complicated, way is to ptrace the parent and force it to wait().
>
>     Or write a little program that just 'wait()'s for the specified
> PID's. That is perfectly portable IMHO. But I must admit that the
> preferred way should be killing the parent. 'init' will reap the
> children after that.

You can only wait() for your own children.

-- 
Måns Rullgård
mru@inprovide.com
