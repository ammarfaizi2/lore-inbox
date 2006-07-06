Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbWGFEqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWGFEqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 00:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbWGFEqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 00:46:04 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:25746 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S965130AbWGFEqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 00:46:02 -0400
Message-ID: <44AC9581.4090701@namesys.com>
Date: Wed, 05 Jul 2006 21:45:53 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] batch-write.patch
References: <44A42750.5020807@namesys.com> <Pine.LNX.4.64.0606291609020.5747@turbotaz.ourhouse>
In-Reply-To: <Pine.LNX.4.64.0606291609020.5747@turbotaz.ourhouse>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase, we incorporated your suggestion, and I want to thank you for it.

Hans

Chase Venters wrote:

> On Thu, 29 Jun 2006, Hans Reiser wrote:
>
>>
>> (patch was attached)
>>
>
> Not quoted because patch isn't inlined, but you're testing for the
> presence of the batch_write pointer repeatedly in the loop. How about
> declare a batch_write ptr on the stack and then do your test once,
> outside of your do { } while (count) loop, and then set it to the
> generic method (before entering the loop) if the generic method isn't
> available?
>
> Thanks,
> Chase
>
>

