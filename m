Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTEIHkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 03:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTEIHkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 03:40:14 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:40408 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S262328AbTEIHkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 03:40:13 -0400
Date: Fri, 9 May 2003 03:50:31 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305090352_MC3-1-3815-126E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>>   So when I register my filesystem, can I indicate that I want to be
>> layered over top of the ext3 driver
>
> Yes.
>
>> and get control anytime someone
>> mounts an ext3 fileystem,
>
> no.

  Does a layered filesystem get all requests for ext3 IO if it's above
it then, or does someone have to manually mount it for each volume?
