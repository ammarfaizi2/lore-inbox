Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWENC7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWENC7j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 22:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWENC7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 22:59:39 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:52627 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932356AbWENC7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 22:59:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=koRdCJzr0+QMnseV1SBB9pdgVeZIP13mHFs+7/xkLUIM2rt/gwLMRWPxNCTiqfcH/vPJwwBktUZHdjfquP4eYMFY7uAyHD1GZ3AAkaqPxwF0hmuTyZBCVOpn2CbjSSLPZQUvDZqs6mmgFwFDWBUz3eNH5M/8id1qINGZ2mA53zI=  ;
Message-ID: <44669D12.5050306@yahoo.com.au>
Date: Sun, 14 May 2006 12:59:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Thompson <michael.craig.thompson@gmail.com>
CC: Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
References: <20060513033742.GA18598@hellewell.homeip.net>	 <44655ECD.10404@yahoo.com.au> <afcef88a0605130921k7139da13k1b7232acb29140c1@mail.gmail.com>
In-Reply-To: <afcef88a0605130921k7139da13k1b7232acb29140c1@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thompson wrote:
> On 5/12/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>> BTW.  I'm not sure if linux-fsdevel has different conventions; however
>> usually you don't break up a patch according to files, but logical
>> components or transformations from one "sane" kernel tree to the next.
>> And that means things keep compiling and working.
> 
> 
> The files themselves are broken down into logical components, so the
> per-file patch approach seems reasonable to me.

Half a filesystem is a logical component?

At the very least it wires up all the kconfig stuff _first_, so it
breaks the tree from about patch 3 until 13.

> 
>> Sometimes big patches are justified.
> 
> 
> This patch format (a whole repost) was requested.

I don't know that whole repost means break up the patches per-file...
Logical might be 1: whole filesystem; 2: debug file+debug calls
throughout 1; 3: documentation.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
