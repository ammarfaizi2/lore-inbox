Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVFHR4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVFHR4R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVFHR4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:56:17 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:61159 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261444AbVFHR4I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:56:08 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw>
	<20050607194123.GA16637@infradead.org>
	<Pine.LNX.4.62.0506071258450.2850@ScMPusgw>
	<1118177949.5497.44.camel@laptopd505.fenrus.org>
	<42A61227.9090402@didntduck.org>
	<Pine.LNX.4.62.0506071519470.19659@ScMPusgw> <87hdg9eq0u.fsf@jbms.ath.cx>
	<1118212178.5655.0.camel@laptopd505.fenrus.org>
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
Date: Wed, 08 Jun 2005 13:56:00 -0400
In-Reply-To: <1118212178.5655.0.camel@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Wed, 08 Jun 2005 08:29:38 +0200")
Message-ID: <87mzq0d973.fsf@jbms.ath.cx>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Tue, 2005-06-07 at 18:54 -0400, Jeremy Maitin-Shepard wrote:
>> AFS writes to the system call table.  

> afaik they stopped doing that for 2.6 now that the syscall table isn't
> exported.

I believe it is still done in 2.6; the syscall table is first located
using various heuristics.

-- 
Jeremy Maitin-Shepard
