Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268383AbRGXRjC>; Tue, 24 Jul 2001 13:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268387AbRGXRiw>; Tue, 24 Jul 2001 13:38:52 -0400
Received: from [64.7.140.42] ([64.7.140.42]:1250 "EHLO inet.connecttech.com")
	by vger.kernel.org with ESMTP id <S268383AbRGXRig>;
	Tue, 24 Jul 2001 13:38:36 -0400
Message-ID: <014a01c11468$01151e00$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0107241405230.20326-100000@duckman.distro.conectiva>
Subject: Re: [RFC] Optimization for use-once pages
Date: Tue, 24 Jul 2001 13:42:26 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

From: "Rik van Riel" <riel@conectiva.com.br>
> Because they occur in a very short interval, an interval MUCH
> shorter than the time scale in which the VM subsystem looks at
> referenced bits, etc...

So what you're sayng is that any number of accesses, as long
as they all occur within the interval < VM subsystem scanning
interval, are all counted as one?

> This seems to be generally accepted theory and practice in the
> field of page replacement.

Okay, just seems odd to me, but IANAVMGuru.

..Stu


