Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVLFAnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVLFAnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVLFAnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:43:49 -0500
Received: from mail.enyo.de ([212.9.189.167]:64640 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S964888AbVLFAnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:43:47 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<1133620264.2171.14.camel@localhost.localdomain>
	<20051203193538.GM31395@stusta.de>
	<1133639835.16836.24.camel@mindpipe>
	<20051203225815.GH25722@merlin.emma.line.org>
	<87y82z5kep.fsf@mid.deneb.enyo.de>
	<1133816764.9356.72.camel@laptopd505.fenrus.org>
Date: Tue, 06 Dec 2005 01:43:43 +0100
In-Reply-To: <1133816764.9356.72.camel@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Mon, 05 Dec 2005 22:06:04 +0100")
Message-ID: <87mzjf2gxs.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven:

>> Well, if there's a CVE name, the proper patch isn't *that* far away
>> (someone has already done a bit of work to isolate the fix).  The real
>> issue seems to be how to make sure that CVE names are assigned during
>> the kernel development process (and not just as an afterthought by the
>> security folks).
>
> security@kernel.org works that way already in a way.

As far as I know, many of the recent CVE assignments for kernel
vulnerabilities have been done by MITRE, requested by individuals
which are neither known as kernel developers, nor vendor security
folks (for "vendor" as in "we have our own legal department with real
lawyers").

Maybe the source of CVE assignments paints a wrong picture.  But if
the CVE picture is correct, vendor-paid kernel developers help behind
the scenes, but there is little interest in openly documenting
security issues, so that users (and what kernel.org considers fringe
distros) can apply the relevant patches if they use kernel.org
kernels.

>From a vendor POV, the lack of official kernel.org advisories may be a
feature.  I find it rather disturbing, and I'm puzzled that the kernel
developer community doesn't view this a problem.  I know I'm alone,
and there are certainly part-time security guys who would be willing
join forces to create something like a kernel.org security bug
database.  But the only answers we get is that everything is fine,
vendors handle the situation, security@kernel.org actually does this
already, etc.

> The hardest part is actually knowing which versions are affected,

First, you need to know that the patch plugs a security hole. 8-) This
isn't always obvious based on the patch, even if the fact is known to
the comitter.
