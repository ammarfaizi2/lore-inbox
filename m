Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVF1UGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVF1UGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVF1UE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:04:28 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:41925 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261240AbVF1UAf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:00:35 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Lameter <christoph@lameter.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
References: <Pine.LNX.4.62.0506281141050.959@graphe.net>
	<87oe9q70no.fsf@jbms.ath.cx> <Pine.LNX.4.62.0506281218030.1454@graphe.net>
	<87hdfi704d.fsf@jbms.ath.cx>
	<1119988068.3175.47.camel@laptopd505.fenrus.org>
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
Date: Tue, 28 Jun 2005 16:00:28 -0400
In-Reply-To: <1119988068.3175.47.camel@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Tue, 28 Jun 2005 21:47:48 +0200")
Message-ID: <87r7em2qw3.fsf@jbms.ath.cx>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> the kernel afs doesnt' seem to need a special syscall....

As I mentioned in a previous message, I believe the in-kernel AFS
supports neither writing nor authentication, making it hardly a viable
replacement of the out-of-kernel OpenAFS for most AFS users.  I believe
OpenAFS requires the system call in order to support authentication.

-- 
Jeremy Maitin-Shepard
