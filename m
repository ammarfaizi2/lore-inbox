Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbTGDDDd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 23:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265757AbTGDDDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 23:03:33 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:28129 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265756AbTGDDDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 23:03:32 -0400
Message-ID: <3F04F56E.5060907@kegel.com>
Date: Thu, 03 Jul 2003 20:33:02 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: chroot bug if arg not absolute path?
References: <3F04F403.2000809@kegel.com>
In-Reply-To: <3F04F403.2000809@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> On my Debian 3.0 system running the 2.4.18 kernel, I
> ran into a funny problem: /usr/sbin/chroot, or the chroot()
> system call followed by the chdir() system call,
> seem to work if their argument is not an absolute path;
> that is, scandir("/bin") can see the files in the jail,
> but execlp("/bin/sh", "/bin/sh", 0) fails to find the /bin/sh
> in the jail, and sets errno to ENOENT.
> 
> Is this a bug, or do I have a screw loose behind the wheel?

The latter.  Ignore me.
- Dan


-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

