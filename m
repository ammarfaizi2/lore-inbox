Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbTEIHlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 03:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbTEIHkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 03:40:20 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:42943 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262334AbTEIHkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 03:40:17 -0400
Date: Fri, 9 May 2003 03:50:31 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Message-ID: <200305090352_MC3-1-3815-126F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>   So when I register my filesystem, can I indicate that I want to be
>> layered over top of the ext3 driver and get control anytime someone
>> mounts an ext3 fileystem, so I can decide whether the volume being
>> mounted is one that I want to intercept open/read/write requests for?
>
> That would assume you had a right to dictate that the administrator
> couldnt mount other file systems without your stacking.

  Security-sensitive upper layers like virus scanners and loggers
would want to do it that way.  The upper layer might even just log
the fact that mount happened and then stay out of the way after that.
