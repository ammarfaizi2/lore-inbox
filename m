Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTEMLgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 07:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTEMLgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 07:36:42 -0400
Received: from nmail1.systems.pipex.net ([62.241.160.130]:37098 "EHLO
	nmail1.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263639AbTEMLgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 07:36:41 -0400
To: <akpm@digeo.com>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <1052826556.3ec0dbbc1d993@netmail.pipex.net>
Date: Tue, 13 May 2003 12:49:16 +0100
From: "Shaheed R. Haque" <srhaque@iee.org>
Cc: <linux-kernel@vger.kernel.org>
References: <1050146434.3e97f68300fff@netmail.pipex.net>  <1050177383.3e986f67b7f68@netmail.pipex.net>  <1050177751.2291.468.camel@localhost>  <1050222609.3e992011e4f54@netmail.pipex.net> <1050244136.733.3.camel@localhost>
In-Reply-To: <1050244136.733.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: PIPEX NetMail 2.2.0-pre13
X-PIPEX-username: aozw65%dsl.pipex.com
X-Originating-IP: 195.166.116.245
X-Usage: Use of PIPEX NetMail is subject to the PIPEX Terms and Conditions of use
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Can I propose an addition?

Not-ready features and speedups
===============================

kernel/fork.c
-------------

- Add ability to restrict the the default CPU affinity mask so that 
sys_setaffinity() can be used to implement exclusive access to a CPU. Patch 
exists on LKML.


