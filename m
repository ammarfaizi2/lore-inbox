Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVF3CUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVF3CUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 22:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVF3CTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 22:19:10 -0400
Received: from web52605.mail.yahoo.com ([206.190.39.143]:59063 "HELO
	web52605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262775AbVF3CSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 22:18:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iuCELz04y/OvybR4kxd92wO52ceeepXdnOIiWpk6rpKbmimmTUX83bN6MRIaBt08xsYM7v9ylT+KVZTMKkya+RTcP5+FTArqyqwHt2zWLVJKFxb+M3eIyA6sinfIOn+ybEju44yLVrXq0d5RcCmpNG3NTDuoKJbuwTodGDE+jxI=  ;
Message-ID: <20050630021800.27887.qmail@web52605.mail.yahoo.com>
Date: Thu, 30 Jun 2005 12:17:59 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: [PROBLEM] kernel BUG at include/linux/blkdev.h:601
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Srihari Vijayaraghavan
<sriharivijayaraghavan@yahoo.com.au> wrote:
> Vanilla 2.6.12 or 2.6.12-git* (the below BUG/Panic
> report is from 2.6.12-git9).
> [...] 
> kernel BUG at include/linux/blkdev.h:601!
> [...]
> EIP is at __ide_end_request+0x118/0x125
> [...]
>  [<c01f5eca>] ide_end_request+0x55/0x57

[Sorry for replying to my own email]

2.6.13-rc1 (plus Hugh's get_request patch) doesn't
suffer from this problem, unlike 2.6.12 and 2.6.12-git
releases.

Thanks
Hari

Send instant messages to your online friends http://au.messenger.yahoo.com 
