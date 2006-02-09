Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWBITY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWBITY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 14:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWBITYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 14:24:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50605 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750726AbWBITYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 14:24:55 -0500
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Kirill Korotaev <dev@openvz.org>, arjan@infradead.org,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 2/7] VPIDs: pid/vpid conversions
References: <43E22B2D.1040607@openvz.org> <43E23179.5010009@sw.ru>
	<m1irrpsifp.fsf@ebiederm.dsl.xmission.com>
	<20060208235348.GC26035@ms2.inr.ac.ru>
	<m11wyd5pv8.fsf@ebiederm.dsl.xmission.com>
	<20060209011126.GB5417@ms2.inr.ac.ru>
	<20060209025135.GA29197@sergelap.austin.ibm.com>
	<20060209095509.GA5747@ms2.inr.ac.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 09 Feb 2006 12:22:43 -0700
In-Reply-To: <20060209095509.GA5747@ms2.inr.ac.ru> (Alexey Kuznetsov's
 message of "Thu, 9 Feb 2006 12:55:09 +0300")
Message-ID: <m13bis2v7g.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru> writes:

> Hello!
>
>> do you mean "preserving some sort of *global* pidspace"?

> Of course.

Ok.  Then my sympathies, I can understand what a difficult position
this places you in.  A global pidspace resembling the one you have now
is the one idea that has been consistently shot down in all of the
discussions.  So I doubt anything short of a miracle could get it
merged in the short term. 

I am fairly certain that everyone who has existing management code at
this point will find it needs modifications to work with whatever
version is merged into the mainstream kernel.

Eric
