Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUIDSrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUIDSrg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 14:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUIDSrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 14:47:36 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:46934 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265517AbUIDSre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 14:47:34 -0400
Message-ID: <413A0DD8.50308@cs.aau.dk>
Date: Sat, 04 Sep 2004 20:47:52 +0200
From: =?UTF-8?B?S3Jpc3RpYW4gU8O4cmVuc2Vu?= <ks@cs.aau.dk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
References: <41385FA5.806@cs.aau.dk>	 <1094220870.7975.19.camel@localhost.localdomain> <4138CE6F.10501@cs.aau.dk> <1094317006.10555.38.camel@localhost.localdomain>
In-Reply-To: <1094317006.10555.38.camel@localhost.localdomain>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2004-09-03 at 21:05, Kristian Sørensen wrote:
> 
>>If an email client receives an malformed email (like the countless 
>>attacks on outlook), a simple restriction could be for the process 
>>handeling the mail would be "$HOME/.addressbook", furthermore, you could 
>>specify that attachments executed _from_ the emailprogram would not have 
>>access to the network. Thus the virus cannot find mail addresses to send 
>>itself to - and it cannot even get network access. Simple and effective.
> 
> 
> ln /tmp/bwhahaha $HOME/.addressbook
> more /tmp/bwhahaha
> 
> As the nice man from the NSA said ;) label content not paths. Use xattrs
> to say "this is an addressbook" and then the path games go away.
Just as Christop Hellwig's suggestion (in this thread) this will not 
work due to the placement of the LSM hooks :-) (he suggested making an 
"mount -o bind").

KS.
