Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUBYXjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUBYXg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:36:28 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:4250 "EHLO fed1mtao06.cox.net")
	by vger.kernel.org with ESMTP id S261624AbUBYXdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:33:52 -0500
To: John Lee <johnl@aurema.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.f12rt3d.c0s9rt@ifi.uio.no> <fa.ishajoq.q5g90m@ifi.uio.no>
From: Junio C Hamano <junkio@cox.net>
Date: Wed, 25 Feb 2004 15:33:50 -0800
In-Reply-To: <fa.ishajoq.q5g90m@ifi.uio.no> (John Lee's message of "Wed, 25
 Feb 2004 22:18:28 GMT")
Message-ID: <7v3c8ypwdd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JL" == John Lee <johnl@aurema.com> writes:

JL> On Wed, 25 Feb 2004, Timothy Miller wrote:

>> Even for those who do, they're not going to want to have to 
>> renice xmms every time they run it.  Furthermore, it seems like a bad 
>> idea to keep marking more and more programs as suid root just so that 
>> they can boost their priority.

I seem to recall reading here that xmms attempts to grab
SCHED_RR if possible.  If that is indeed the case, I suspect
that the above suggestion to run xmms as root does not let the
user exploit the strength of EBS.  Since, as I understand it,
EBS affects SCHED_NORMAL processes not SCHED_RR processes.


