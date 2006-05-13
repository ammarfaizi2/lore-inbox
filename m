Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWEMEVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWEMEVk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 00:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWEMEVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 00:21:39 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:33372 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750865AbWEMEVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 00:21:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=yx7jcfkSqhIbR0ViwqBZ6slQG35Y4R5HVPRRnEHGifPPGZmxrnsveNcfE7qBoPj3GVcwGs4v834vWJ7q1R61ZbOtscUroAk9dfkHpWs4tWI849kOxP6cJngmV9ySCxmqE2SUTXkpTD/OAZ4Ipi2OML76fCv04BfgNqeGiJm6SCU=  ;
Message-ID: <44655ECD.10404@yahoo.com.au>
Date: Sat, 13 May 2006 14:21:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Phillip Hellewell <phillip@hellewell.homeip.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
References: <20060513033742.GA18598@hellewell.homeip.net>
In-Reply-To: <20060513033742.GA18598@hellewell.homeip.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Hellewell wrote:
> This patch set constitutes the 0.1.7 release of the eCryptfs
> cryptographic filesystem:
> 
> http://ecryptfs.sourceforge.net/
> 
> It includes numerous updates based on comments on the 0.1.6 submission
> made on May 4th. The only functional change worth noting is the
> removal of the unnecessary second read in ecryptfs_get1page() and
> ecryptfs_do_readpage().
> 
> This patch set was produced and tested against the 2.6.17-rc3-mm1
> release of the kernel.

BTW.  I'm not sure if linux-fsdevel has different conventions; however
usually you don't break up a patch according to files, but logical
components or transformations from one "sane" kernel tree to the next.
And that means things keep compiling and working.

Sometimes big patches are justified.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
