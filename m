Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVBXSkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVBXSkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVBXSkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:40:47 -0500
Received: from calma.pair.com ([209.68.1.95]:23563 "HELO calma.pair.com")
	by vger.kernel.org with SMTP id S261579AbVBXSiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:38:51 -0500
Date: Thu, 24 Feb 2005 13:38:51 -0500
From: "Chad N. Tindel" <chad@tindel.net>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Mike Galbraith <EFAULT@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050224183851.GA24359@calma.pair.com>
References: <20050224075756.GA18639@calma.pair.com> <30111.1109237503@www1.gmx.net> <20050224175331.GA18723@calma.pair.com> <421E1AC1.1020901@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E1AC1.1020901@nortel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Low-latency userspace apps.  The audio guys, for instance, are trying to 
> get latencies down to the 100us range.
> 
> If random kernel threads can preempt userspace at any time, they wreak 
> havoc with latency as seen by userspace.

Come now.  There is no such thing as a random kernel thread.  Any General
Purpose kernel needs the ability to do work that keeps the entire system from 
grinding to a halt.  

Chad
