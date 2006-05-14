Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWEND1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWEND1G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 23:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWEND1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 23:27:06 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:46219 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932364AbWEND1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 23:27:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qWXNbZTlSV8fQg8ITdRzkaWkVmnWDNy5mEr6x+E0m7e+7BtETB3QNuTpfpD1dqTKcfEyEdf9onorGPxwbUtCpNXrrdV2I9vyEYt84+zvI3RNs8a7wrIBd4TXjJbLTiKm5ZP+44Yo6OfmecI31mTZskmkCcSQV0ae5bk4uBHVliU=  ;
Message-ID: <4466A37F.4030601@yahoo.com.au>
Date: Sun, 14 May 2006 13:26:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: michael.craig.thompson@gmail.com, phillip@hellewell.homeip.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       jmorris@namei.org, sct@redhat.com, ezk@cs.sunysb.edu,
       dhowells@redhat.com
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
References: <20060513033742.GA18598@hellewell.homeip.net>	<44655ECD.10404@yahoo.com.au>	<afcef88a0605130921k7139da13k1b7232acb29140c1@mail.gmail.com>	<44669D12.5050306@yahoo.com.au> <20060513201341.63590cff.akpm@osdl.org>
In-Reply-To: <20060513201341.63590cff.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>> Half a filesystem is a logical component?
>>
>> At the very least it wires up all the kconfig stuff _first_, so it
>> breaks the tree from about patch 3 until 13.
> 
> 
> Doesn't matter.  The rule is stated as "kernel should compile at each
> step", but the _real_ rule is "don't break git-bisect".
> 

Compiling at each step is better than not. But my main point is
that it is superfluously broken into multiple patches.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
