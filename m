Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267595AbSLMBl4>; Thu, 12 Dec 2002 20:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267596AbSLMBl4>; Thu, 12 Dec 2002 20:41:56 -0500
Received: from sneakemail.com ([207.106.87.13]:61605 "HELO
	monkey.sneakemail.com") by vger.kernel.org with SMTP
	id <S267595AbSLMBly>; Thu, 12 Dec 2002 20:41:54 -0500
Message-ID: <5095-51149@sneakemail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux/alpha vs. 2.4.20 and ISO9660 vs long file names
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Dec 2002 17:49:42 -0800
From: "Stephen Williams" <zhig9f05jg02@sneakemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this is an alpha-specific problem, but I am having
some troubles with the off-the-shelf 2.4.20 kernel on a RedHat 7.2
system (upgraded from 7.1).

For some reason, ls is having trouble with long file names on the
disk. I follow with strace, and getdents64 is returning the right
number of entries, but then ls tries to lstat a truncated name.
I can't say of the getdirent64 is trundating the name, but it seems
likely.

The ls program itself is likely fine because I don't see this
problem when running 2.4.18. Also, other programs that get directory
listings have troubles with the longer file names on ISO CDROMS.
Furthermore, shorter file names (still longer then 8 characters)
work fine.

P.S. I'm not subscribed to the list. Please CC me.

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
steve at picturel.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


