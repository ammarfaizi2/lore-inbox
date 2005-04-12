Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263011AbVDLVeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbVDLVeP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbVDLVaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:30:24 -0400
Received: from fmr19.intel.com ([134.134.136.18]:36505 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262551AbVDLV3R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:29:17 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FUSYN and RT
Date: Tue, 12 Apr 2005 14:28:58 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02FD4558@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FUSYN and RT
Thread-Index: AcU/piSu4EH5tLoPQn24o0OFqvJjTQAADB3Q
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <dwalker@mvista.com>, <joe.korty@ccur.com>
Cc: <linux-kernel@vger.kernel.org>, <mingo@elte.hu>
X-OriginalArrivalTime: 12 Apr 2005 21:29:00.0216 (UTC) FILETIME=[A437AB80:01C53FA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Daniel Walker [mailto:dwalker@mvista.com]
>
>> Well yeah, but you could lock a fusyn, then invoke a system call
which
>> locks a kernel semaphore.
>
>Right .. For deadlock detection, I want to assume that the fusyn lock
is
>on the outer level. That way both deadlock detection system will work
>properly (in theory).

So that would mean to create a restriction (which is implicit
now, anyway): "a system call cannot return holding an rt-mutex"
right? 

-- Inaky 
