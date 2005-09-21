Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVIURao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVIURao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVIURao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:30:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11413 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751290AbVIURan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:30:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       len.brown@intel.com, Pierre Ossman <drzeus-list@drzeus.cx>,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 21 Sep 2005 11:28:55 -0600
In-Reply-To: <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org> (Linus
 Torvalds's message of "Wed, 21 Sep 2005 09:35:20 -0700 (PDT)")
Message-ID: <m1slvycotk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 21 Sep 2005, Pavel Machek wrote:
>> 
>> I think you are not following the proper procedure. All the patches
>> should go through akpm.

Ok.  I thought it was fine to send simple and obviously correct bug
fixes to Linus.

> One issue is that I actually worry that Andrew will at some point be where 
> I was a couple of years ago - overworked and stressed out by just tons and 
> tons of patches. 
>
> Yes, he's written/modified tons of patch-tracking tools, and the git 
> merging hopefully avoids some of the pressures, but it still worries me. 
> If Andrew burns out, we'll all suffer hugely.
>
> I'm wondering what we can do to offset those kinds of issues. I _do_ like 
> having -mm as a staging area and catching some problems there, so going 
> through andrew is wonderful in that sense, but it has downsides.

It is especially challenging for people like me who typically work on
parts of the kernel without a maintainer.  So there frequently isn't
an intermediate I can submit my patches to.

Eric
