Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267744AbSLGKJt>; Sat, 7 Dec 2002 05:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267745AbSLGKJt>; Sat, 7 Dec 2002 05:09:49 -0500
Received: from basket.ball.reliam.net ([213.91.6.7]:4364 "EHLO
	basket.ball.reliam.net") by vger.kernel.org with ESMTP
	id <S267744AbSLGKJs>; Sat, 7 Dec 2002 05:09:48 -0500
Date: Sat, 7 Dec 2002 11:15:18 +0100
From: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Mailer: The Bat! (v1.60q)
Reply-To: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Priority: 3 (Normal)
Message-ID: <1702768901.20021207111518@uni.de>
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re[4]: [STATUS] fbdev api.
In-Reply-To: <1039256356.1066.6.camel@localhost.localdomain>
References: <6723376646.20021206204207@uni.de>
 <1039218931.989.24.camel@localhost.localdomain>
 <15835232027.20021206235940@uni.de>
 <1039256356.1066.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Antonino,

Saturday, December 7, 2002, 11:22:07 AM, you wrote:

>> >> c) instruction:          | produces:
>> >>    ======================|==================
>> >>    1. typing abc def     | $ abc def
>> >>                          |          ^ (<- cursor)
>> >>    2. going three chars  | $ abc def
>> >>       ro the left        |       ^
>> >>    3. pressing backspace | $ abcddef
>> >>                          |      ^
>> >>    4. pressing enter     | -bash: abcdef: command not found
>> >>                          |

AD> Can you try this? It should fix the problem you mentioned as well as the
AD> emacs glitch.  Also, a quick fix for character map generation failures
AD> (KDFONTOP ioctl), ie when selecting console fonts.  Finally, if fbdev
AD> supports blanking, let's use that.
AD> [..patch..]
 
Ah, good job! Now working at the shell prompt is usable again. Many
thanks for your time exposure.

AD> Tony
-- 
cheers,
 Tobias

