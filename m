Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279190AbRKVNVx>; Thu, 22 Nov 2001 08:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279201AbRKVNVf>; Thu, 22 Nov 2001 08:21:35 -0500
Received: from chiark.greenend.org.uk ([195.224.76.132]:15369 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S279190AbRKVNVY>; Thu, 22 Nov 2001 08:21:24 -0500
From: Colin Watson <cjwatson@flatline.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: fs/exec.c and binfmt-xxx in 2.4.14
In-Reply-To: <3BFBDFA5.DDA1CC98@evision-ventures.com>
Organization: riva.ucam.org
Message-Id: <E166tn8-00066U-00@chiark.greenend.org.uk>
Date: Thu, 22 Nov 2001 13:21:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BFBDFA5.DDA1CC98@evision-ventures.com>, Martin Dalecki wrote:
>Heinz-Ado Arnolds wrote:
>> I have a problem with loading modules for binary formats. The
>> reason for this problem shows up in fs/exec.c search_binary_handler().
>> 
>> Starting with linux-2.1.23 (and up to 2.4.14) there was a change
>> in the format and offset of printing the magic number for requesting
>> a handler module. Up to 2.1.22 the statement
>
>That is a time span of several years during which nobody realized there
>was a problem with this. Therefore I would rather request for removal
>of the whole binfmt-misc stuff (which is ugly anyway) rather then
>"fixing it" ;-)

This report has nothing to do with binfmt_misc - it's in the main binfmt
code.

-- 
Colin Watson                                  [cjwatson@flatline.org.uk]
