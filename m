Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313403AbSDGRRM>; Sun, 7 Apr 2002 13:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313407AbSDGRRL>; Sun, 7 Apr 2002 13:17:11 -0400
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:7838 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S313403AbSDGRRL>;
	Sun, 7 Apr 2002 13:17:11 -0400
Date: Sun, 7 Apr 2002 18:14:52 +0100
Message-Id: <200204071714.g37HEqs17610@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Two fixes for 2.4.19-pre5-ac3
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020407181154.A1608@infradead.org>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020407181154.A1608@infradead.org> you wrote:
> On Sun, Apr 07, 2002 at 12:43:57PM -0400, Steven N. Hirsch wrote:
>> And, unless this is reversed the OpenAFS kernel module won't load (it 
>> needs sys_call_table.):
> 
> sys_call_table was unexported for a reason - OpenAFS is broken by design
> if it messes with the syscall table.

it replaces/overrides existing syscalls from a module. I'd call that
broken by design yes.
