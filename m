Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262791AbSJaQR6>; Thu, 31 Oct 2002 11:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSJaQR6>; Thu, 31 Oct 2002 11:17:58 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:35773 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S262791AbSJaQRy>; Thu, 31 Oct 2002 11:17:54 -0500
Message-ID: <3DC15931.9030601@verizon.net>
Date: Thu, 31 Oct 2002 11:24:17 -0500
From: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Dax Kelson <dax@gurulabs.com>, Chris Wedgwood <cw@f00f.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
References: <Pine.GSO.4.21.0210310241230.13031-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [64.223.81.164] at Thu, 31 Oct 2002 10:24:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alexander Viro wrote:

>On 31 Oct 2002, Dax Kelson wrote:
>
>>I think the normal intent is to let Sally, Joe, and Bill have their own
>>private directory protected from THE REST OF THE USERS.
>>
>>If a member of your trusted circle goes rogue, then, yup you are screwed
>>for the moment. It shouldn't last a whole month though.
>>
>>That is what backups, and employment termination is for.
>>    
>>
>
>Then give them all the same account and be done with that.  Effect will
>be the same.
>  
>

Unless I'm missing something, that only works if all the users need 
*exactly* the same permissions to all files, which isn't a good assumption.

Example:  Sally is an accountant, Joe and Bill are engineers.

Bill and Joe are working on a project, and Sally is cost control for 
that project - they all need access to the project files.  Bill and Joe 
do not need access to officer salary data, but Sally does.  Bill and Joe 
need access to other projects (not necessarily the same ones), but Sally 
doesn't.  Oops.

- Steve


