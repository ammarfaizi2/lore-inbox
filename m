Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293111AbSCFDmU>; Tue, 5 Mar 2002 22:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293167AbSCFDmL>; Tue, 5 Mar 2002 22:42:11 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:60570 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S293111AbSCFDmA>;
	Tue, 5 Mar 2002 22:42:00 -0500
Message-ID: <3C859007.50102@candelatech.com>
Date: Tue, 05 Mar 2002 20:41:59 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: a faster way to gettimeofday?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a program that I very often need to calculate the current
time, with milisecond accuracy.  I've been using gettimeofday(),
but gprof shows it's taking a significant (10% or so) amount of
time.  Is there a faster (and perhaps less portable?) way to get
the time information on x86?  My program runs as root, so should
have any permissions it needs to use some backdoor hack if that
helps!

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


