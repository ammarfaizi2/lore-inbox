Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUAHLKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 06:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbUAHLKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 06:10:36 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:38122 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264291AbUAHLKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 06:10:33 -0500
Message-ID: <3FFD3AA7.7000007@namesys.com>
Date: Thu, 08 Jan 2004 14:10:31 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] fs/fcntl.c - remove impossible <0 check in do_fcntl -
 arg is unsigned.
References: <8A43C34093B3D5119F7D0004AC56F4BC074B2059@difpst1a.dif.dk> <Pine.LNX.4.58.0401071846160.2131@home.osdl.org> <Pine.LNX.4.56.0401081034200.10083@jju_lnx.backbone.dif.dk>
In-Reply-To: <Pine.LNX.4.56.0401081034200.10083@jju_lnx.backbone.dif.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Code is like poetry --- bloat needs to come out of it, and a rigorous 
discipline of removing all unnecessary complexity from it needs to be 
made a habit so that the exact meaning  of it will be seen by all.

Boy was that pompous.;-) Oh well, I'd like the reiserfs portions of his 
patch to be accepted, and I'll forward them to you in a few days.  
Please consider accepting them.

Hans

Jesper Juhl wrote:

>On Wed, 7 Jan 2004, Linus Torvalds wrote:
>  
>
>
>> The fact that the compiler can optimize
>>away one of the tests if the type is right i2Ds fine. It seems to be
>>draconian to remove code that is correct and safe, especially when the
>>code has no real downsides to it.
>>    
>>


-- 
Hans


