Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVEaAk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVEaAk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVEaAk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:40:57 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:35537 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261846AbVEaAkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 20:40:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Christian Schmid <webmaster@rapidforum.com>
Subject: Re: vm-issues in 2.6.12-rc5
Date: Tue, 31 May 2005 10:43:00 +1000
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <429B2ACA.5040901@rapidforum.com>
In-Reply-To: <429B2ACA.5040901@rapidforum.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505311043.00105.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005 01:01 am, Christian Schmid wrote:
> Even in 2.6.12rc5 the vm-problem is still there. On a gigabit-webserver,
> when it reaches around 4000 downloaders, it slows-down immediately. Its no
> fs-issue or disk-issue because the lock-ups also happen when I try to open
> a file on /proc. Normally it needs no time to open it but when it reaches
> 4000 sockets, it needs from 5-30 seconds to just open a "file". Its a dual
> Xeon with 8 GB Ram. Any idea?

Have you tried getting a profile output to see what it is doing during these 
slowdowns?

Cheers,
Con
