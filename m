Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268497AbRHKQM6>; Sat, 11 Aug 2001 12:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268503AbRHKQMs>; Sat, 11 Aug 2001 12:12:48 -0400
Received: from storm.ca ([209.87.239.69]:42888 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S268497AbRHKQMd>;
	Sat, 11 Aug 2001 12:12:33 -0400
Message-ID: <3B755995.E876230C@storm.ca>
Date: Sat, 11 Aug 2001 12:13:09 -0400
From: Sandy Harris <sandy@storm.ca>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: struct page to 36 (or 64) bit bus address?
In-Reply-To: <20010809151022.C1575@sventech.com> <E15UvLO-0007tH-00@the-village.bc.nu> <15218.61869.424038.30544@pizda.ninka.net> <20010809163531.D1575@sventech.com> <20010811175626.O19169@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> ... (the API says that if you get null out of the map call you
> should fallback, but no driver checks for this null retval and so in
> turn they're all prone to crash, not going to be fixed in 2.4 I guess).

That strikes me as a pretty basic programming error. Why on Earth is
it not considered a problem urgently needing a fix?
