Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUGEQv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUGEQv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 12:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266152AbUGEQv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 12:51:58 -0400
Received: from quest.jpl.nasa.gov ([137.78.177.125]:8939 "EHLO
	quest.jpl.nasa.gov") by vger.kernel.org with ESMTP id S266149AbUGEQv5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 12:51:57 -0400
In-Reply-To: <20040705064010.C9BFB5F7AA@attila.bofh.it>
References: <2e9is-5YT-1@gated-at.bofh.it> <2e9iu-5YT-5@gated-at.bofh.it> <2ecq2-80i-1@gated-at.bofh.it> <7ab39013.0407042237.40ea9035@posting.google.com> <20040705064010.C9BFB5F7AA@attila.bofh.it>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9FC7DA98-CEA3-11D8-B083-000A95820F30@alumni.caltech.edu>
Content-Transfer-Encoding: 7bit
From: Mark Adler <madler@alumni.caltech.edu>
Subject: Re: [PATCH] gcc 3.5 fixes
Date: Mon, 5 Jul 2004 09:51:56 -0700
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote in 
message news:<2ecq2-80i-1@gated-at.bofh.it>...
> Can't we just remove these variables?
...
>> -static const char inflate_copyright[] =
>> +static const char inflate_copyright[] __attribute_used__ =
>>     " inflate 1.1.3 Copyright 1995-1998 Mark Adler ";

It's there for a reason -- to have a copyright notice in the 
executable.  I would prefer it if it were not removed.  Thanks.

mark

