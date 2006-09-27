Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965556AbWI0LFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965556AbWI0LFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965561AbWI0LFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:05:55 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:52742 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965556AbWI0LFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:05:54 -0400
Message-ID: <451A5AD3.6060403@shadowen.org>
Date: Wed, 27 Sep 2006 12:04:51 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andre Noll <maan@systemlinux.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ian Campbell <Ian.Campbell@xensource.com>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
References: <45185A93.7020105@google.com> <m1venaqeg6.fsf@ebiederm.dsl.xmission.com> <20060927095839.GK20462@skl-net.de> <200609271226.44834.ak@suse.de>
In-Reply-To: <200609271226.44834.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 27 September 2006 11:58, Andre Noll wrote:
>> On 19:35, Eric W. Biederman wrote:
>>> I have seen this one as well,
>> Me too. Current linus git tree, x86_64 SMP, gcc-3.3.5, GNU ld version 2.15, binutils
>> 2.15-6, Debian.
> 
> We can probably revert the notes patch for now, since it is only needed
> for Xen which isn't even merged yet.
> 
> Ian, do you think you can do the notes in some different way that still
> works with old binutils?
> 
> -Andi

In my testing, backing out the old patch and putting the one mentioned
in the following message seems to work:

http://lists.xensource.com/archives/html/xen-devel/2006-08/msg01416.html

-apw
