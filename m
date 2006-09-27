Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWI0Qyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWI0Qyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWI0Qyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:54:50 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:53511 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751254AbWI0Qyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:54:49 -0400
Message-ID: <451AAC9D.1080603@shadowen.org>
Date: Wed, 27 Sep 2006 17:53:49 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ian Campbell <Ian.Campbell@xensource.com>,
       Andre Noll <maan@systemlinux.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
References: <45185A93.7020105@google.com> <200609271226.44834.ak@suse.de> <1159355329.28313.29.camel@localhost.localdomain> <200609271405.03849.ak@suse.de>
In-Reply-To: <200609271405.03849.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> The xen-unstable tree has had the .bss movement patch in for a couple of
>> weeks now with no reported bugs. We are frozen for the release 3.0.3 so
>> at least in theory people should be testing it pretty hard ;-)
> 
> Ok maybe we should retry it. The BSS movement patch makes sense by
> itself after all and in theory really shouldn't break anything.
> I'll reenable it.

This change seems to have just hit mainline in 2.6.18-git7.  Perhaps we
need to expedite the fix to mainline.

-apw
