Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbREVOWd>; Tue, 22 May 2001 10:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbREVOWX>; Tue, 22 May 2001 10:22:23 -0400
Received: from h24-69-31-7.gv.shawcable.net ([24.69.31.7]:23058 "HELO
	bodnar42.dhs.org") by vger.kernel.org with SMTP id <S261778AbREVOWJ>;
	Tue, 22 May 2001 10:22:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Me <bodnar42@bodnar42.dhs.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [PATCH] include/linux/coda.h
Date: Tue, 22 May 2001 07:21:55 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <01052121242000.31459@bodnar42.dhs.org> <20010522091831.D6103@cs.cmu.edu>
In-Reply-To: <20010522091831.D6103@cs.cmu.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01052207215501.32103@bodnar42.dhs.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 May 2001 06:18, you wrote:
> Are you trying to compile a Linux kernel on a FreeBSD machine, or is
> this a bug in the Coda kernel module in the FreeBSD tree?
>
Sorry, I should've been more specific. I'm trying to compile the Linux kernel 
(2.4.5pre3) on a FreeBSD machine, which actually works quite well with this 
patch applied. This is the only place in the core that FreeBSD gets hung up 
on (init/main.c seems to include it unconditionally). Some drivers may still  
make incorrect assumptions about __linux__ being defined, though.

-Ryan
