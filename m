Return-Path: <linux-kernel-owner+w=401wt.eu-S932331AbXAISJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbXAISJB (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbXAISI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:08:59 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:41926 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331AbXAISI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:08:59 -0500
Message-ID: <45A3DA39.70604@s5r6.in-berlin.de>
Date: Tue, 09 Jan 2007 19:08:57 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Akula2 <akula2.shark@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Jumping into Kernel development: About -rc kernels...
References: <8355959a0701090733l74d03792q16b3022d949c7ae1@mail.gmail.com>
In-Reply-To: <8355959a0701090733l74d03792q16b3022d949c7ae1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akula2 wrote:
> Should I start compile/test/debug one-after-one in this fashion:-
> 
> 2.6.19 source + patch-2.6.20-rc1
> 2.6.19 source + patch-2.6.20-rc2
> 2.6.19 source + patch-2.6.20-rc3
> 2.6.19 source + patch-2.6.20-rc4

Or

linux-2.6.19 + testing/patch-2.6.20-rc1 = linux-2.6.20-rc1
linux-2.6.20-rc1 + testing/incr/patch-2.6.20-rc1-rc2 = linux-2.6.20-rc2
linux-2.6.20-rc2 + testing/incr/patch-2.6.20-rc2-rc3 = linux-2.6.20-rc3

and so on.

> OR
> 
> Pick the latest release number?

Or this. Or use git as was suggested by others, to track kernel changes
in a finer-grained manner. Or try the -mm patchset which has --- how
shall I call it --- pre-release code. Or track some subsystem-specific
or architecture-specific development trees if you are especially
interested in a platform or driver subsystem. See the MAINTAINERS file
for their development repositories. These repos do not always carry
self-contained source trees though, and what purposes they serve for the
maintainers and how they can be used by others than the maintainers
differs from repo to repo.
-- 
Stefan Richter
-=====-=-=== ---= -=--=
http://arcgraph.de/sr/
