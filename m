Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVBLWnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVBLWnS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 17:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVBLWnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 17:43:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:46579 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261208AbVBLWnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 17:43:15 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm2
References: <20050210023508.3583cf87.akpm@osdl.org>
	<20050210133524.GA4544@infradead.org>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 12 Feb 2005 23:43:02 +0100
Message-ID: <87ll9tjt6x.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Feb 10, 2005 at 02:35:08AM -0800, Andrew Morton wrote:
>> 
>> - Added the mlock and !SCHED_OTHER Linux Security Module for the audio guys.
>>   It seems that nothing else is going to come along and this is completely
>>   encapsulated.
>
> Even if we accept a module that grants capabilities to groups this isn't fine
> yet because it only supports two specific capabilities (and even those two in
> different ways!) instead of adding generic support to bind capabilities to
> groups.

Unless I misunderstood the code, this one is available for
quite some time: <http://www.olafdietsche.de/linux/accessfs/>
or a newer, self-contained version <http://lkml.org/lkml/2005/1/11/221>

Or you could use a real solution - filesystem capabilities:
<http://www.olafdietsche.de/linux/capability/> and if you don't like
this one :-), there's also an alternative existing here:
<http://www.stanford.edu/~luto/linux-fscap/>

Regards, Olaf.
