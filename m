Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSHOL1H>; Thu, 15 Aug 2002 07:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSHOL1H>; Thu, 15 Aug 2002 07:27:07 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:1950 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S316775AbSHOL1G>; Thu, 15 Aug 2002 07:27:06 -0400
Date: Thu, 15 Aug 2002 13:30:51 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
Message-ID: <20020815113051.GA18146@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
	linux-kernel@vger.kernel.org
References: <20020815050343.A27963@kushida.apsleyroad.org> <Pine.LNX.4.44.0208150837510.2197-100000@localhost.localdomain> <20020815113148.A28398@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020815113148.A28398@kushida.apsleyroad.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 11:31:48AM +0100, Jamie Lokier wrote:
>    - intercept all the system calls that might call mmput(); that is,
>      exit() and execve()), just so it can move the thread-specific data
>      (including the stack) onto the "potentially free list".

And the reason why i cannot intercept exit() or exec... again somewhere
in my threaded program is...?
