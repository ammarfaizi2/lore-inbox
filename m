Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136077AbREJMW7>; Thu, 10 May 2001 08:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136111AbREJMWt>; Thu, 10 May 2001 08:22:49 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:41963 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S136077AbREJMWn>; Thu, 10 May 2001 08:22:43 -0400
From: Stefan Hoffmeister <lkml.2001@econos.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux thread problem
Date: Thu, 10 May 2001 14:21:24 +0200
Organization: Econos
Message-ID: <mp1lftkha1ml8fr1lq3osrc4ns52u9i39u@4ax.com>
In-Reply-To: <NJMIGAKMNAMIKAAA@mailcity.com>
In-Reply-To: <NJMIGAKMNAMIKAAA@mailcity.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: On Thu, 10 May 2001 02:19:41 -0700, sachin kitnawat wrote:

>	I am porting an Threading Application from Hp-UX 11.0 
>to Red Hat Linux 6.2. There is a system call pthread_condattr_setpshared 
>and pthread_mutex_setpshared in HP-UX which is not available on Linux.

Newer glibc versions (2.2+) have this.

Try 

  http://sources.redhat.com/glibc/

Note that all this is user space, not kernel space.
