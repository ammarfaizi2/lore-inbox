Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTEKDn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 23:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbTEKDn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 23:43:57 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:58030 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S262268AbTEKDnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 23:43:55 -0400
Date: Sat, 10 May 2003 23:54:25 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <Pine.LNX.4.44.0305102301160.16611-100000@marcellos.corky.net>
Message-ID: <Pine.LNX.4.33.0305102346340.25095-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 May 2003, Yoav Weiss wrote:

> You're right, which is why I wouldn't offer it as a general mechanism.  I
> was merely offering a method to solve the current issue and fix Masud's
> problem.  This solution is good in many cases but dangerous in others.  It
> can be used as long as you inspect the original syscall to make sure its
> param is just a simple string/int.  True in most cases though.

Like any security solution, if the vulnerabilities are identifiable and
outlinable then the risk can be approximated. This is what is really
needed in real-life situations, reallistically, we simply want an
assessment of risk to clearly define what is and isn't acceptable level of
protection.

I will attempt to actually build attack scenarios based on these comments
and post results to any one who is interested.

Just as an aside, my solution isn't actually performing its control
through user-space params requiring copy_from_user.

Cheers,

Ahmed.

