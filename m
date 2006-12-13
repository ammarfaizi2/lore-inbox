Return-Path: <linux-kernel-owner+w=401wt.eu-S964784AbWLMKGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWLMKGg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 05:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWLMKGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 05:06:36 -0500
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:3069 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932639AbWLMKGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 05:06:35 -0500
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 05:06:34 EST
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: cfq performance gap
References: <457F583B.9090109@linux.vnet.ibm.com> <000001c71e76$d4930e90$bb89030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
Date: 13 Dec 2006 09:56:58 GMT
Message-ID: <457fce6a$0$334$e4fe514c@news.xs4all.nl>
X-Trace: 1166003818 news.xs4all.nl 334 [::ffff:194.109.0.112]:33386
X-Complaints-To: abuse@xs4all.nl
In-Reply-To: <000001c71e76$d4930e90$bb89030a@amr.corp.intel.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <000001c71e76$d4930e90$bb89030a@amr.corp.intel.com>,
Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
>This rawio test plows through sequential I/O and modulo each small record
>over number of threads.  So each thread appears to be non-contiguous within
>its own process context, overall request hitting the device are sequential.
>I can't see how any application does that kind of I/O pattern.

A NNTP server that has many incoming connections, handled by
multiple threads, that stores the data in cylic buffers ?

Mike.
