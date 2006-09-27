Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWI0OOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWI0OOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 10:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWI0OOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 10:14:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60292 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932265AbWI0OOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 10:14:06 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Ian Campbell <Ian.Campbell@xensource.com>,
       Andre Noll <maan@systemlinux.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Andy Whitcroft <apw@shadowen.org>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
References: <45185A93.7020105@google.com> <200609271226.44834.ak@suse.de>
	<1159355329.28313.29.camel@localhost.localdomain>
	<200609271405.03849.ak@suse.de>
Date: Wed, 27 Sep 2006 08:11:39 -0600
In-Reply-To: <200609271405.03849.ak@suse.de> (Andi Kleen's message of "Wed, 27
	Sep 2006 14:05:03 +0200")
Message-ID: <m1d59ho0v8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> The xen-unstable tree has had the .bss movement patch in for a couple of
>> weeks now with no reported bugs. We are frozen for the release 3.0.3 so
>> at least in theory people should be testing it pretty hard ;-)
>
> Ok maybe we should retry it. The BSS movement patch makes sense by
> itself after all and in theory really shouldn't break anything.
> I'll reenable it.

I think some part of the relocatable kernel or kexec on panic work
had problems with the bss in the middle as well.

Eric
