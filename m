Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759352AbWLBBPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759352AbWLBBPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 20:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759357AbWLBBPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 20:15:09 -0500
Received: from codepoet.org ([166.70.99.138]:53950 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1759352AbWLBBPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 20:15:06 -0500
Date: Fri, 1 Dec 2006 18:15:05 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061202011505.GA2728@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Christoph Anton Mitterer <calestyo@scientia.net>,
	linux-kernel@vger.kernel.org
References: <4570CF26.8070800@scientia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4570CF26.8070800@scientia.net>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Dec 02, 2006 at 01:56:06AM +0100, Christoph Anton Mitterer wrote:
> The issue was basically the following:
> I found a severe bug mainly by fortune because it occurs very rarely.
> My test looks like the following: I have about 30GB of testing data on
> my harddisk,... I repeat verifying sha512 sums on these files and check
> if errors occur.
> One test pass verifies the 30GB 50 times,... about one to four
> differences are found in each pass.

Doh!  I have a Tyan S2895 in my system, and I've been pulling my
hair out trying to track down the cause of a similar somewhat
rare failure for the pre-computer sha1 of a block of data to
actually match the calculated sha1.  I'd been hunting in vain the
past few days trying to find a cause -- looking for buffer
overflows, non thread safe code, or similar usual suspects.

It is a relief to see I am not alone!

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
