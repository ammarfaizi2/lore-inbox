Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbTIAAoJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbTIAAoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:44:09 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:15550 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263094AbTIAAoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:44:07 -0400
Message-ID: <3F529A95.4030509@kegel.com>
Date: Sun, 31 Aug 2003 18:02:13 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jamie@shareable.org
Subject: Re: Andrea VM changes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie () shareable ! org> wrote:
> I'd love to be able to select which app _doesn't_ deserve the axe.
> I.e. not sshd, and then not httpd.

I tried adding a hinting system that let the user
tweak the badness calculated by the OOM killer.
Didn't help.   No matter how I tried to protect
important processes, there was always a case where
the OOM killer ended up killing them anyway.

That was probably just a weakness in how I did the
hinting.  You might be able to do it with some sort of
'for god's sake never ever kill this process' tweak,
but before I tried that, I realized that making OOM
conditions halt the system was what I really wanted
for my users.

- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

