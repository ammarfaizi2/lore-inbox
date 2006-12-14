Return-Path: <linux-kernel-owner+w=401wt.eu-S1752049AbWLOAM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbWLOAM6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbWLOAM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:12:58 -0500
Received: from mail.gurulabs.com ([67.137.148.7]:58187 "EHLO mail.gurulabs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbWLOAM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:12:58 -0500
X-Greylist: delayed 2000 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 19:12:57 EST
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives //
	memory hole mapping related bug?!
From: Dax Kelson <dax@gurulabs.com>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4570CF26.8070800@scientia.net>
References: <4570CF26.8070800@scientia.net>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 16:39:36 -0700
Message-Id: <1166139576.3307.20.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-02 at 01:56 +0100, Christoph Anton Mitterer wrote:
> Hi.
> 
> Perhaps some of you have read my older two threads:
> http://marc.theaimsgroup.com/?t=116312440000001&r=1&w=2 and the even
> older http://marc.theaimsgroup.com/?t=116291314500001&r=1&w=2
> 
> The issue was basically the following:
> I found a severe bug mainly by fortune because it occurs very rarely.
> My test looks like the following: I have about 30GB of testing data on
> my harddisk,... I repeat verifying sha512 sums on these files and check
> if errors occur.
> One test pass verifies the 30GB 50 times,... about one to four
> differences are found in each pass.

This sounds very similar to a corruption issue I was experiencing on my
nforce4 based system. After replacing most of my hardware to no avail, I
discovered that if increased the voltage for my RAM chips the corruption
went away. Note that I was not overclocking at all.

Worth a try.

Dax Kelson


