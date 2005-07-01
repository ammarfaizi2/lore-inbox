Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263276AbVGAISU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbVGAISU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 04:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbVGAIST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 04:18:19 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:9747 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263276AbVGAIRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 04:17:23 -0400
Message-ID: <42C4FC14.7070402@slaphack.com>
Date: Fri, 01 Jul 2005 03:17:24 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
Cc: Al Boldi <a1426z@gawab.com>, "'Nathan Scott'" <nathans@sgi.com>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: XFS corruption during power-blackout
References: <20050629001847.GB850@frodo> <200506290453.HAA14576@raad.intranet> <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org>
In-Reply-To: <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Wed, Jun 29, 2005 at 07:53:09AM +0300, Al Boldi wrote:
> 
> 
>>What I found were 4 things in the dest dir:
>>1. Missing Dirs,Files. That's OK.
>>2. Files of size 0. That's acceptable.
>>3. Corrupted Files. That's unacceptable.
>>4. Corrupted Files with original fingerprint. That's ABSOLUTELY
>>unacceptable.
> 
> 
> disk usually default to caching these days and can lose data as a
> result, disable that

Not always possible.  Some disks lie and leave caching on anyway.
