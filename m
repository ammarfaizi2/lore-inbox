Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933791AbWKWQBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933791AbWKWQBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933794AbWKWQBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:01:24 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:48848 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S933791AbWKWQBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:01:23 -0500
Message-ID: <4565C5D2.3070104@s5r6.in-berlin.de>
Date: Thu, 23 Nov 2006 17:01:22 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] WorkStruct: Shrink work_struct by two thirds
References: <20061122132008.2691bd9d.akpm@osdl.org>  <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com> <10039.1164293972@redhat.com>
In-Reply-To: <10039.1164293972@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Andrew Morton <akpm@osdl.org> wrote:
>> waaaaaaaay too many rejects for me, sorry.
...
> Actually... there is a way to do this sort of incrementally,
...
> Might that help?

I'd say, do it one step, as quickly as you can. And do it on top of
-rc1. For now you could test for yourself to rebase your current
patchset onto -mm --- just to get an impression of the steps you will
have to go through once you have an -rc1 to work with.

Maybe it's a bit less trouble if you split the patchset per subsystem,
in a similar manner as the various patch collections in -mm are divided
per subsystem or subproject. This would also allow you to reuse parts of
an -mm rebase from now for a -rc1 rebase later. I.e. go for more
parallelism, not for more sequential steps. (...am I naively suggesting,
without any own experience in such things.)
-- 
Stefan Richter
-=====-=-==- =-== =-===
http://arcgraph.de/sr/
