Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274975AbTHPXGh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 19:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274976AbTHPXGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 19:06:37 -0400
Received: from oak.sktc.net ([64.71.97.14]:64493 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id S274975AbTHPXGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 19:06:36 -0400
Message-ID: <3F3EB8FA.1080605@sktc.net>
Date: Sat, 16 Aug 2003 18:06:34 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Michael Frank <mhf@linuxmail.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
References: <200308170410.30844.mhf@linuxmail.org> <200308162049.h7GKnwnP024716@turing-police.cc.vt.edu>
In-Reply-To: <200308162049.h7GKnwnP024716@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> Consider this code:
> 
> 	char *foo = 0;
> 	sigset(SIGSEGV,SIG_IGNORE);
> 	for(;;) { *foo = '\5'; }
> 
> Your logfiles just got DoS'ed....


Why not then just log uncaught exceptions?

