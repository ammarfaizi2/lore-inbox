Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbTELDkj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 23:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbTELDkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 23:40:39 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:49136 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261847AbTELDki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 23:40:38 -0400
Date: Sun, 11 May 2003 20:53:09 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC]  new syscall to allow notification when arbitrary pids die
Message-ID: <20030511205309.A25546@google.com>
References: <3EBC9C62.5010507@nortelnetworks.com> <20030510073842.GA31003@actcom.co.il> <3EBF144E.7050608@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EBF144E.7050608@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Sun, May 11, 2003 at 11:26:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 11:26:06PM -0400, Chris Friesen wrote:
> 
> Its cheaper and faster.  It only costs a single call for each process, and
> then you get notified immediately when it dies.

On Solaris, pwait(1) opens /proc/pid/psinfo and waits for data.

/fc
