Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWC2Ut7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWC2Ut7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 15:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWC2Ut7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 15:49:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16299 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750947AbWC2Ut6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 15:49:58 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       devel@openvz.org, serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru>
	<20060324211917.GB22308@MAIL.13thfloor.at>
	<m1psk7enfm.fsf@ebiederm.dsl.xmission.com> <4428F902.1020706@sw.ru>
	<1143664234.9731.47.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 29 Mar 2006 13:47:20 -0700
In-Reply-To: <1143664234.9731.47.camel@localhost.localdomain> (Dave Hansen's
 message of "Wed, 29 Mar 2006 12:30:34 -0800")
Message-ID: <m17j6dgeqv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Tue, 2006-03-28 at 12:51 +0400, Kirill Korotaev wrote:
>> Eric, we have a GIT repo on openvz.org already:
>> http://git.openvz.org 
>
> Git is great for getting patches and lots of updates out, but I'm not
> sure it is idea for what we're trying to do.  We'll need things reviewed
> at each step, especially because we're going to be touching so much
> common code.
>
> I'd guess set of quilt (or patch-utils) patches is probably best,
> especially if we're trying to get stuff into -mm first.

Git is as good at holding patches as quilt.  It isn't quite as
good at working with them as quilt but in the long term that is
fixable.

The important point is that we get a collection of patches that
we can all agree to, and that we publish it.

At this point it sounds like each group will happily publish the
patches, and that might not be a bad double check, on agreement.

Then we have someone send them to Andrew.  Or we have a quilt or
a git tree that Andrew knows he can pull from.

But we do need lots of review so distribution to Andrew and the other
kernel developers as plain patches appears to be the healthy choice.
I'm going to go bury my head in the sand and finish my OLS paper now.


Eric
