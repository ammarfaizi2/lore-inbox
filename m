Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTELDTw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 23:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTELDTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 23:19:52 -0400
Received: from www.wireboard.com ([216.151.155.101]:60840 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id S261449AbTELDTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 23:19:51 -0400
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC]  new syscall to allow notification when arbitrary pids die
References: <3EBC9C62.5010507@nortelnetworks.com>
	<20030510073842.GA31003@actcom.co.il>
	<3EBF144E.7050608@nortelnetworks.com>
From: Doug McNaught <doug@mcnaught.org>
Date: 11 May 2003 23:32:29 -0400
In-Reply-To: Chris Friesen's message of "Sun, 11 May 2003 23:26:06 -0400"
Message-ID: <m3y91cj0vm.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> writes:

> > There's already a well established way to do what you want (get
> > non-immediate notification of process death). What benefit would your
> > approach give?
> 
> Its cheaper and faster.  It only costs a single call for each process,
> and then you get notified immediately when it dies.

Rather than a new syscall, what about a magic file or device that you
can poll()? 

-Doug
