Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbUJXSoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbUJXSoF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 14:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUJXSoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 14:44:05 -0400
Received: from smtp-out-01.utu.fi ([130.232.202.171]:62719 "EHLO
	smtp-out-01.utu.fi") by vger.kernel.org with ESMTP id S261579AbUJXSoC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 14:44:02 -0400
Date: Sun, 24 Oct 2004 21:43:42 +0300
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: Bug? Load avg 2.0 when idle.
In-reply-to: <20041024182918.GA12532@sommrey.de>
To: Joerg Sommrey <jo175@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <200410242143.51025.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <20041024182918.GA12532@sommrey.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 October 2004 21:29, Joerg Sommrey wrote:
> Hello,
> 
> there is a load average of 2.0+ even if the box is almost idle. (i.e. "top"
> shows just one running process: top itself.) Starting two cpu-intensive
> processes raises the load average to 4.0+.  How can I determine the
> source for the high load, or is this a bug?
> I'm running 2.6.9 on a dual-athlon box.

Look for processes stuck in D state...
