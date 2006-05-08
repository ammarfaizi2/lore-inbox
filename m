Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWEHIBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWEHIBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 04:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWEHIBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 04:01:38 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:3041 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932181AbWEHIBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 04:01:38 -0400
Message-ID: <445EFB01.6090100@hozac.com>
Date: Mon, 08 May 2006 10:02:09 +0200
From: Daniel Hokka Zakrisson <daniel@hozac.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
References: <445E80DD.9090507@hozac.com> <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org> <Pine.LNX.4.64.0605072033530.3718@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605072033530.3718@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 7 May 2006, Linus Torvalds wrote:
> 
>>Trond wrote an alternate patch for the actual problem which I sent 
>>separately, but it would probably be good to have more safety in the slab 
>>layer by default regardless.
> 
> 
> And here's Trond's suggested locks.c fix.

I can confirm that it does fix the two issues.

-- 
Daniel Hokka Zakrisson
