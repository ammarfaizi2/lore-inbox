Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRDBNEd>; Mon, 2 Apr 2001 09:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRDBNEN>; Mon, 2 Apr 2001 09:04:13 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:60432 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129156AbRDBNEM>; Mon, 2 Apr 2001 09:04:12 -0400
Date: Mon, 2 Apr 2001 10:02:31 -0300
From: Gustavo Niemeyer <niemeyer@conectiva.com>
To: linux-kernel@vger.kernel.org
Subject: Re: can not compile 2.4.3 on alpha
Message-ID: <20010402100230.B15554@tux.distro.conectiva>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3AC86511.F3123F6C@lmt.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <3AC86511.F3123F6C@lmt.lv>; from andrejs@lmt.lv on Mon, Apr 02, 2001 at 02:40:01PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrejs!!

> [linux] make dep;make clean;make boot
[...]
> /usr/src/linux-2.4.3/include/asm/pgalloc.h:334: conflicting types for
> `pte_alloc'
> /usr/src/linux-2.4.3/include/linux/mm.h:399: previous declaration of
> `pte_alloc'
> /usr/src/linux-2.4.3/include/asm/pgalloc.h:352: conflicting types for
> `pmd_alloc'
> /usr/src/linux-2.4.3/include/linux/mm.h:412: previous declaration of
> `pmd_alloc'
> make: *** [init/main.o] Error 1
[...]

This is happening on ia64 as well. The interface seems to have changed
but some architectures were forgotten.

-- 
Gustavo Niemeyer

[ 2AAC 7928 0FBF 0299 5EB5  60E2 2253 B29A 6664 3A0C ]
