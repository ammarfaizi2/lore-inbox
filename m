Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUJSU17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUJSU17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 16:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269738AbUJSU0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 16:26:18 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:3066 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266236AbUJSULb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 16:11:31 -0400
Subject: Re: process start time set wrongly at boot for kernel 2.6.9
From: john stultz <johnstul@us.ibm.com>
To: Jerome Borsboom <j.borsboom@erasmusmc.nl>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george@mvista.com
In-Reply-To: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl>
References: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl>
Content-Type: text/plain
Message-Id: <1098216701.20778.78.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 19 Oct 2004 13:11:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 11:21, Jerome Borsboom wrote:
> Starting with kernel 2.6.9 the process start time is set wrongly for 
> processes that get started early in the boot process. Below is a dump from 
> my 'ps' command. Note the start time for processes 1-12. After process 12 
> the start time is set right.

How reproducible is this? Are the correct and incorrect time values
always off by the same amount? 

Are you running NTP? I'm curious if you are changing your system time
during boot. 

thanks
-john

