Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWBPMKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWBPMKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 07:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWBPMKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 07:10:22 -0500
Received: from ns1.forescout.com ([194.90.25.83]:54945 "EHLO fs0.forescout.com")
	by vger.kernel.org with ESMTP id S1030296AbWBPMKV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 07:10:21 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: Questions about pthread
Date: Thu, 16 Feb 2006 14:10:18 +0200
Message-ID: <5AF1F1D1E5A5D6439B308F35EA4603F50867C5@sol.fsd.forescout.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Questions about pthread
Thread-Index: AcYy8fPlfR+QOzMQQKWKw5nvipMG+w==
From: "Revital Eres" <revitale@forescout.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I understand that every system call is a cancellation point for pthreads. My question is how can I avoid this to happen; meaning- to forbid the cancellation point in the system call wrapper. (I call a system call from a cleanup function that is just been cancelled) 

I tried to avoid it by setting pthread_setcancelstate (PTHREAD_CANCEL_DISABLE, &old_state); before calling the system call, but than if the thread had been cancelled the process just stuck.


Thanks for the help.




