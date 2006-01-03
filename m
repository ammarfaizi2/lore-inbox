Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWACOvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWACOvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWACOvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:51:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:28322 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932396AbWACOvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:51:23 -0500
Date: Tue, 3 Jan 2006 15:51:19 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 17/26] kbuild: Fix genksyms handling of DEFINE_PER_CPU(struct
 foo_s *, bar);
In-Reply-To: <20060103144940.GB18012@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0601031550370.436@yvahk01.tjqt.qr>
References: <11362947262643@foobar.com> <Pine.LNX.4.61.0601031546100.436@yvahk01.tjqt.qr>
 <20060103144940.GB18012@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >When a .c file contains:
>> >DEFINE_PER_CPU(struct foo_s *, bar);
>> >
>> >the .cpp output looks like:
>>      ^^^^
>> 
>> Are you right about C++?
>
>It's the pre-processed output with DEFINE_PER_CPU expanded, not C++.
>
Oh ok. (According to gcc(1), that's called ".i")


Jan Engelhardt
-- 
