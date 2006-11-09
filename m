Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424155AbWKIR1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424155AbWKIR1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424162AbWKIR1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:27:48 -0500
Received: from terminus.zytor.com ([192.83.249.54]:60856 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1424155AbWKIR1s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:27:48 -0500
Message-ID: <455364E7.80509@zytor.com>
Date: Thu, 09 Nov 2006 09:27:03 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jakub Jelinek <jakub@redhat.com>, Mike Galbraith <efault@gmx.de>,
       Albert Cahalan <acahalan@gmail.com>,
       Bill Nottingham <notting@redhat.com>,
       Marco Roeland <marco.roeland@xs4all.nl>,
       Michael Kerrisk <mtk-manpages@gmx.net>
Subject: Re: [PATCH] sysctl: Undeprecate sys_sysctl
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com> <20061108204948.GC20284@devserv.devel.redhat.com>
In-Reply-To: <20061108204948.GC20284@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, Nov 08, 2006 at 12:00:10PM -0700, Eric W. Biederman wrote:
>> Now that I know there are a few real users the only sane way to
>> proceed with deprecation is to push the time limit out to a year or
>> two work and work with distributions that have big testing pools like
>> fedora core to find these last remaining users.
> 
> Some early boot code needs to know the kernel version and
> it needs to do it before /proc is mounted and potentially in order
> to run mount. In places it has its role but only in places.

uname() provides the kernel version.

	-hpa


