Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269344AbTCDJiV>; Tue, 4 Mar 2003 04:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269345AbTCDJiV>; Tue, 4 Mar 2003 04:38:21 -0500
Received: from denise.shiny.it ([194.20.232.1]:61377 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S269344AbTCDJiU>;
	Tue, 4 Mar 2003 04:38:20 -0500
Message-ID: <XFMail.20030304104847.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200303041636.00745.kernel@kolivas.org>
Date: Tue, 04 Mar 2003 10:48:47 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: xmms (audio) skipping in 2.5 (not 2.4)
Cc: Con Kolivas <kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Try an -mm 
> kernel with the scheduler tunables patch and try playing with the max
> timeslice. Most have found that <=25 will usually stop these skips. The
> default max timeslice of 300ms is just too long for the desktop and
> interactivity estimator.

IMHO 300ms is way too much. Timeslice should be in the 10-50ms range
to get good interactive performance. Why is it so long ?

Bye.

