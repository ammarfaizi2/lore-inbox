Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUCTOTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 09:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbUCTOTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 09:19:09 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:59877 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263415AbUCTOTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 09:19:07 -0500
Message-ID: <000801c40e86$4f068390$0716a8c0@carbon>
From: "Rob Roschewsk" <bangzoom@comcast.net>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
References: <002501c40e02$1ff8f7b0$0716a8c0@carbon> <20040320083857.GB3961@mars.ravnborg.org>
Subject: Re: 2.6 newbie question RE: MODULES
Date: Sat, 20 Mar 2004 09:19:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, In all of my flailing to solve the problem I was so focused on the
modules I never copied the new bzImage into the boot directory .... it
seemed to click when I read this. Copied it over ... modules load OK now.

--> Rob



On Fri, Mar 19, 2004 at 05:32:55PM -0500, Rob Roschewsk wrote:
>
> Version magic '2.6.4 686 gcc-3.2' should be '2.6.4 SMP preempt PENTIUM III
> gcc-3.2'

The running kernel is compiled as SMP, with preempt enabled, and for the
PENTIUM III processor.
You must match this configuration to laod the modules.

Sam

