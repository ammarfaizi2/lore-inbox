Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVHIUVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVHIUVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbVHIUVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:21:07 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:62935 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S964931AbVHIUVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:21:06 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: capabilities patch (v 0.1)
To: Chris Wright <chrisw@osdl.org>, David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Tue, 09 Aug 2005 22:21:00 +0200
References: <4zuQJ-20d-11@gated-at.bofh.it> <4zv0l-2b8-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1E2aaq-0002WB-Tj@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
> * David Madore (david.madore@ens.fr) wrote:

>> * Second, a much more extensive change, the patch introduces a third
>> set of capabilities for every process, the "bounding" set.  Normally
> 
> this is not a good idea.  don't add more sets. if you really want to
> work on this i'll give you all the patches that have been done thus far,
> plus a set of tests that look at all the execve, ptrace, setuid type of
> corner cases.

How are you going to tell processes that may exec suid (or set-capability-)
programs from those that aren't supposed to gain certain capabilities?

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
