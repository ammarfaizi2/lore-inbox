Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTEHPRb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbTEHPRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:17:31 -0400
Received: from pat.uio.no ([129.240.130.16]:750 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261686AbTEHPRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:17:30 -0400
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: hch@infradead.org
CC: hch@infradead.org, alan@lxorguk.ukuu.org.uk, terje.eggestad@scali.com,
       arjanv@redhat.com, linux-kernel@vger.kernel.org, D.A.Fedorov@inp.nsk.su
In-reply-to: <20030508152543.A6895@infradead.org> (message from Christoph
	Hellwig on Thu, 8 May 2003 15:25:43 +0100)
Subject: Re: The disappearing sys_call_table export.
MIME-Version: 1.0
Message-Id: <E19DnLH-0002As-00@aqualene.uio.no>
Date: Thu, 8 May 2003 17:29:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Christoph Hellwig]
>> The only problem I can see is that different modules overloading the
>> same function needs to be unloaded in the correct order. Is this the
>> only reason for removing it, or am I missing something?

> it's racy - and it doesn't work on half of the arches added over the
> last years.

Would you be so kind as to explain exactly what is racy? Just
asserting that it is does not help me understand anything.

-- 
 - Terje
malmedal@usit.uio.no
