Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbTDVKFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 06:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbTDVKFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 06:05:01 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:28872 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S263045AbTDVKFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 06:05:00 -0400
Date: Tue, 22 Apr 2003 06:12:55 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] Runtime memory barrier patching
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304220616_MC3-1-356C-831C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 
>> Is that true even on the 32-bit Athlons, especially the older ones?
>
> It is not the recommended form for Athlons (see my other mail) 
> But I doubt it's a big issue. The Athlon has a pretty good decoder.


 Doesn't Athlon do best with just a string of 0x90 because it treats
it as a real NOP and discards it very early in the CPU pipeline? It
broke the bogomips estimator when they were introduced...



------
 Chuck
