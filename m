Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266215AbUGJLmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUGJLmp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 07:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUGJLmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 07:42:45 -0400
Received: from mx07.ms.so-net.ne.jp ([202.238.82.7]:39082 "EHLO
	mx07.ms.so-net.ne.jp") by vger.kernel.org with ESMTP
	id S266215AbUGJLmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 07:42:42 -0400
Message-ID: <40EFD5DB.3000100@turbolinux.co.jp>
Date: Sat, 10 Jul 2004 20:41:15 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.5) Gecko/20031231
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
CC: Jesper Juhl <juhl-lkml@dif.dk>, Con Kolivas <kernel@kolivas.org>,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: post 2.6.7 BK change breaks Java?
References: <40EEB1B2.7000800@kolivas.org> <Pine.LNX.4.56.0407091954160.22376@jjulnx.backbone.dif.dk>
In-Reply-To: <Pine.LNX.4.56.0407091954160.22376@jjulnx.backbone.dif.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list.

Jesper Juhl wrote:
> On Fri, 9 Jul 2004, Con Kolivas wrote:
> 
> 
>>>On Tue, 6 Jul 2004, Matthias Andree wrote:
>>>>Hi,
>>>>
>>>>I've pulled from the linux-2.6 BK tree some post-2.6.7 version,
>>compiled
>>>>and installed it, and it breaks Java, standalone or plugged into
>>>>firefox, the symptom is that the application catches SIGKILL. This
>>>>didn't happen with stock 2.6.7 and doesn't happen with 2.6.6 either.

If I removed this changeset, java worked.
http://linux.bkbits.net:8080/linux-2.6/cset@1.1743

Is this "rt_sigsuspend() and sigaltstack() prototype change" right?
If so, how do we resolve user side?

