Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbTDLTon (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 15:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTDLTon (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 15:44:43 -0400
Received: from nmail1.systems.pipex.net ([62.241.160.130]:50110 "EHLO
	nmail1.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263385AbTDLTom (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 15:44:42 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: Re: Processor sets (pset) for linux kernel 2.5/2.6?
Message-ID: <1050177383.3e986f67b7f68@netmail.pipex.net>
Date: Sat, 12 Apr 2003 20:56:23 +0100
From: "Shaheed R. Haque" <srhaque@iee.org>
Cc: <thockin@isunix.it.ilstu.edu>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
In-Reply-To: <1050146434.3e97f68300fff@netmail.pipex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: PIPEX NetMail 2.2.0-pre13
X-PIPEX-username: aozw65%dsl.pipex.com
X-Originating-IP: 81.86.202.62
X-Usage: Use of PIPEX NetMail is subject to the PIPEX Terms and Conditions of use
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hmmm, AFAICS, sched_getaffinity() and sched_setaffinity() 
allow the calling process to be bound to the nominated CPU(s), but that is not 
the same as giving them exclusive access, is it? In other words, other 
processes which have no particualr affinity needs can presumably still be 
scheduled to run on the same processor. 

I am looking for something more akin to the patch I referred to...or did I miss 
something in the effect of set_cpus_allowed()?

Thanks for the replies, Shaheed


