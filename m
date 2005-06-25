Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVFYS5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVFYS5N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 14:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFYS5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 14:57:13 -0400
Received: from relay1.beelinegprs.ru ([217.118.71.5]:64702 "EHLO
	relay1.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S261237AbVFYSzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 14:55:24 -0400
From: Alexander Zarochentsev <zam@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: reiser4 plugins
Date: Sat, 25 Jun 2005 22:55:28 +0400
User-Agent: KMail/1.8
Cc: reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <42B8B9EE.7020002@namesys.com> <20050621181802.11a792cc.akpm@osdl.org>
In-Reply-To: <20050621181802.11a792cc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506252255.29208.zam@namesys.com>
X-SpamTest-Info: Profile: Formal (248/050617)
X-SpamTest-Info: Profile: Detect Hard No RBL (4/030526)
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (2/030321)
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0129], SpamtestISP/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 June 2005 05:18, Andrew Morton wrote:
> Hans Reiser <reiser@namesys.com> wrote:
> > What is wrong with having an encryption plugin implemented in this
> >  manner?  What is wrong with being able to have some files implemented
> >  using a compression plugin, and others in the same filesystem not.
> >
> >  What is wrong with having one file in the FS use a write only plugin, in
> >  which the encrypion key is changed with every append in a forward but
> >  not backward computable manner, and in order to read a file you must
> >  either have a key that is stored on another computer or be reading what
> >  was written after the moment of cracking root?
> >
> >  What is wrong with having a set of critical data files use a CRC
> >  checking file plugin?
>
> I think the concern here is that this is implemented at the wrong level.

> In Linux, a filesystem is some dumb thing which implements
> address_space_operations, filesystem_operations, etc.
>

It is not so already.  XFS, FUSE, network fs are not of that type.

Thanks,
Alex.

