Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTIMBTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 21:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbTIMBTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 21:19:47 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.45]:29081 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261982AbTIMBTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 21:19:46 -0400
Date: Fri, 12 Sep 2003 21:19:20 -0400
From: Iker <iker@computer.org>
Subject: self piping and context switching
To: linux-kernel@vger.kernel.org
Reply-to: Iker <iker@computer.org>
Message-id: <039401c37995$0f30cbd0$3203a8c0@duke>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assume a thread is monitoring a set of fd's which include both ends of
a pipe (using poll, for example). If the thread writes to the pipe (in
order to notify itself for whatever reason) is it reasonable to expect
that it will be able to return to its poll loop and get the event
without a context switch? (provided it quickly returns to the poll
loop).

Regards,
Iker


