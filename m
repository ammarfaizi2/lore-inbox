Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267098AbTBDAm5>; Mon, 3 Feb 2003 19:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbTBDAm5>; Mon, 3 Feb 2003 19:42:57 -0500
Received: from mgw-dax2.ext.nokia.com ([63.78.179.217]:9907 "EHLO
	mgw-dax2.ext.nokia.com") by vger.kernel.org with ESMTP
	id <S267098AbTBDAm4> convert rfc822-to-8bit; Mon, 3 Feb 2003 19:42:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Kernel Threads question on 2.4
Date: Mon, 3 Feb 2003 16:52:27 -0800
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A8026B2335@mvebe001.americas.nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel Threads question on 2.4
Thread-Index: AcLL5214EC6gqbc+RySgn8UY0vIGIw==
From: <Akram.Abou-Emara@nokia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Feb 2003 00:52:28.0689 (UTC) FILETIME=[B0FA9010:01C2CBE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a couple of questions:

Do kernel threads get preempted? Or do they have to
give up the CPU on their own? 

Are there any rules for what scheduling policies and
priority a kernel thread can have?
reparent_to_init()sets the scheduling policy to
SCHED_OTHER. Do you see a problem with changing the
scheduling policy to  SCHED_FIFO?

Thanks,
Akram
