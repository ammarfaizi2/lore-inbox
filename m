Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbRE2ITU>; Tue, 29 May 2001 04:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261355AbRE2ITK>; Tue, 29 May 2001 04:19:10 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:29456 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S261351AbRE2ITA>; Tue, 29 May 2001 04:19:00 -0400
From: dth@trinity.hoho.nl (Danny ter Haar)
Subject: Re: BUG REPORT: 2.4.4 hang on large network transfers with RTL-8139
Date: Tue, 29 May 2001 08:19:01 +0000 (UTC)
Organization: Holland Hosting
Message-ID: <9evm1l$el7$1@voyager.cistron.net>
In-Reply-To: <20010529142019.C757@ws17.krasu.ru>
X-Trace: voyager.cistron.net 991124341 15015 195.64.82.84 (29 May 2001 08:19:01 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Voloshin  <vav@isv.ru> wrote:
>2.4.3 works Ok, 2.4.4 and 2.4.5 both has this problem.
>Lamer's assumption: maybe troubles with sendfile() after zero-copy patches?

no, the patch in 2.4.3-ac7 caused a lot of problems for
a lot of people. Simply compile 8139too.c from an old
kernel on to the latest/greatest and you have best
of both worlds ;-)

People are working on this issue!

Danny
-- 
Holland Hosting
www.hoho.nl      info@hoho.nl

