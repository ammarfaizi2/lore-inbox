Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288511AbSADGmB>; Fri, 4 Jan 2002 01:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288512AbSADGlu>; Fri, 4 Jan 2002 01:41:50 -0500
Received: from nlaknet.slt.lk ([203.115.0.2]:7624 "EHLO laknet.slt.lk")
	by vger.kernel.org with ESMTP id <S288511AbSADGlp>;
	Fri, 4 Jan 2002 01:41:45 -0500
Message-ID: <3C35F8B2.98763627@sltnet.lk>
Date: Fri, 04 Jan 2002 12:47:14 -0600
From: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17-9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@zip.com.au
Subject: Re: losetuping files in tmpfs fails?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

Andrew Morton wrote:

> Yup, tmpfs doesn't provide some of the facilities which the
<snip>
> It's not obvious that there's a burning need to support loop-on-tmpfs
> though, is there?

	No, there isn't. I noticed this myself a few months back, but didn't
complain because, well, the purpose of tmpfs is to provide support for
POSIX shared memory, right? (At least according to Configure.help).
{If,/ Because} tmpfs does that correctly, it's not broken.
	The only app I've encountered that breaks with this is mkinitrd and
associates, but it should at least attempt to fallback to the user's
home directory IMHO (without complaining "you're all out of loop
devices" - an old Redhat mkinitrd).

Cheerio!

	 - ioj
