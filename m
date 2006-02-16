Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWBPL7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWBPL7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 06:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWBPL7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 06:59:36 -0500
Received: from fs0.forescout.com ([194.90.25.83]:16801 "EHLO fs0.forescout.com")
	by vger.kernel.org with ESMTP id S932230AbWBPL7f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 06:59:35 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: 
Date: Thu, 16 Feb 2006 13:59:33 +0200
Message-ID: <5AF1F1D1E5A5D6439B308F35EA4603F50867C4@sol.fsd.forescout.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Index: AcYy8HNgUzi4G3xYT/GmJ7fZmD0pUQ==
From: "Revital Eres" <revitale@forescout.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I understand that every system call is a cancellation point for pthreads. My question is how can I avoid this to happen; meaning- to forbid the cancellation point in the system call wrapper. (I call a system call from a cleanup function that is just been cancelled) 

I tried to avoid it by setting pthread_setcancelstate (PTHREAD_CANCEL_DISABLE, &old_state); before calling the system call, but than if the thread had been cancelled the process just stuck.


Thanks for the help.



