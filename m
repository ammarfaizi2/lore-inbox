Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTEKQtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 12:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTEKQtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 12:49:09 -0400
Received: from franka.aracnet.com ([216.99.193.44]:49878 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261754AbTEKQtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 12:49:08 -0400
Date: Sun, 11 May 2003 07:47:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bug on shutdown from 68-mm4
Message-ID: <12530000.1052664451@[10.10.2.4]>
In-Reply-To: <20030510231120.580243be.akpm@digeo.com>
References: <8570000.1052623548@[10.10.2.4]><20030510224421.3347ea78.akpm@digeo.com><8880000.1052624174@[10.10.2.4]> <20030510231120.580243be.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Sorry if this is old news, haven't been paying attention for a week.
>> >>  Bug on shutdown (just after it says "Power Down") from 68-mm4.
>> >>  (the NUMA-Q).
>> > 
>> > Random guess: is it related to CONFIG_KEXEC?
>> 
>> Don't think so - I don't have that enabled. Config file is attatched.
> 
> It doesn't matter - the kexec patch tends to futz with stuff like that
> regardless of CONFIG_KEXEC.
> 
> It doesn't happen here.  Could you please retest without the kexec
> patch applied?

Yup, backing out kexec fixes it.

