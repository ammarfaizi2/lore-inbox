Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUFJT2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUFJT2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUFJT2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:28:34 -0400
Received: from inett.biz ([62.92.76.9]:46799 "EHLO skynet")
	by vger.kernel.org with ESMTP id S262459AbUFJT2c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:28:32 -0400
Date: Thu, 10 Jun 2004 21:27:52 +0200
From: =?iso-8859-1?Q?B=E5rd?= Kalbakk <baard@inett.biz>
To: linux-kernel@vger.kernel.org
Cc: stian@nixia.no
Subject: Re: timer + fpu stuff locks my console race
Message-ID: <20040610192752.GA18267@inett.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.28i
X-Editor: Vim http://www.vim.org/ > Please keep me in CC as I'm not on the mailinglist. I'm currently on a > vaccation, so I can't hook my linux-box to the Internet, but I came > across a race condition in the "old" 2.4.26-rc1 vanilla kernel. > I'm doing some code tests when I came across problems with my program > locking my console (even X if I'm using a xterm). > I think first of all gcc triggers the problem, so the full report is here: > http://gcc.gnu.org/bugzilla/show_bug.cgi?id=15905 > Stian Skjelstad
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACK on 2.6.7-rc2 singel CPU. 

But, with 2.4.23 SMP it seems to be okay. I can't kill the process or attach to it with strace, but it doesn't lock the machine.

Bård Kalbakk
