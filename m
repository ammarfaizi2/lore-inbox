Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316237AbSEQO1i>; Fri, 17 May 2002 10:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316238AbSEQO1h>; Fri, 17 May 2002 10:27:37 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:7326 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S316237AbSEQO1e>; Fri, 17 May 2002 10:27:34 -0400
Message-ID: <3CE5136E.F826040C@cisco.com>
Date: Fri, 17 May 2002 19:57:58 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems
X-Mailer: Mozilla 4.51C-CISCOENG [en] (X11; I; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Schaefer <frank.schafer@setuza.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: counters
In-Reply-To: <3CE3BECB.FF1AE6A@ail.com> <1021614923.253.0.camel@ADMIN> 
		<3CE4C895.EB34A245@cisco.com> <1021632473.250.1.camel@ADMIN>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Schaefer wrote:

> Hi Manik
> 
> and sorry that I read only half of your initial post.
> I had a quick look at fs/read_write.c.
> 
> I don't see any hook in the functions here, to perform such a task. And
> here this should belong to -- shouldn't it?

	quite right. I am wondering if any locking is required for updating
	some counters which one may add in task_struct or if adding counters
	in task_struct is acceptable at all.
