Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284553AbRLIWbr>; Sun, 9 Dec 2001 17:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284569AbRLIWbh>; Sun, 9 Dec 2001 17:31:37 -0500
Received: from 24-163-106-43.he2.cox.rr.com ([24.163.106.43]:65197 "EHLO
	asd.ppp0.com") by vger.kernel.org with ESMTP id <S284553AbRLIWbU>;
	Sun, 9 Dec 2001 17:31:20 -0500
Date: Sun, 9 Dec 2001 17:31:17 -0500
Subject: Re: [PATCH] Make highly niced processes run only when idle
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: root <r6144@263.net>, linux-kernel@vger.kernel.org
To: Robert Love <rml@tech9.net>
From: Anthony DeRobertis <asd@suespammers.org>
In-Reply-To: <1007786393.12110.4.camel@phantasy>
Message-Id: <75F30A52-ECF4-11D5-80FE-00039355CFA6@suespammers.org>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.475)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday, December 7, 2001, at 11:39 , Robert Love wrote:

> What do you think will happen when an "idle" task holds a 
> resource or is
> otherwise a producer for something a higher priority, running, task
> needs?

One of two things:
	1) The higher priority task will no longer be runnable; or
	2) We gave enough rope to hang yourself, and, well, you did.


