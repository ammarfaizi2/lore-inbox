Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270228AbTGRMoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271699AbTGRMoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:44:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:38602 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S270228AbTGRMn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:43:59 -0400
To: joe briggs <jbriggs@briggsmedia.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: run-parts,find, kupdated: What are they and how to control
 them?
References: <200307180925.24867.jbriggs@briggsmedia.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Fri, 18 Jul 2003 14:58:46 +0200
In-Reply-To: <200307180925.24867.jbriggs@briggsmedia.com> (joe briggs's
 message of "Fri, 18 Jul 2003 09:25:24 -0400")
Message-ID: <87lluwyos9.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joe briggs <jbriggs@briggsmedia.com> writes:

> Please - can someone explain what happens here once a day when my machine 
> becomes completely unusable, a tremendous amount of disk i/o begins to occur, 
> and 'top' shows "run-parts" and "find" at > 80% cpu utilization. What are 
> they doing?  Are they necessary?  Can they be controlled. In Googling for 
> these answers first, all I see are compaints, but no answers. Can someone 
> PLEASE either explain what these are doing and how they are controlled, or 
> point me in the right direction? Many thanks.

This has nothing to do with the kernel. I guess, it's a cron job. Do a

$ grep find /etc/crontab /etc/cron*/*

and look wether one of the entries corresponds with the time when your
machine becomes unusable.

Regards, Olaf.
