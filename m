Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTJVRAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 13:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTJVRAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 13:00:55 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:24324 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263485AbTJVRAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 13:00:55 -0400
Subject: Re: Fix x86 subarch breakage by the patch to allow more APIC irq
	sources
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, jamesclv@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0310220929350.1586-100000@home.osdl.org>
References: <Pine.LNX.4.44.0310220929350.1586-100000@home.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 22 Oct 2003 11:59:31 -0500
Message-Id: <1066841973.12312.81.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-22 at 11:31, Linus Torvalds wrote:
> I'd much rather do this the other way: I _detest_ "generic" values that 
> architectures can override, when just defining the value in the 
> architecture directly is smaller than the test for the generic value.

That's fine by me...I was originally going to do it that way until I saw
that two other subarchs had the same problem.

James


