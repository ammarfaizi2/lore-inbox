Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132806AbRDYV64>; Wed, 25 Apr 2001 17:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132805AbRDYV6q>; Wed, 25 Apr 2001 17:58:46 -0400
Received: from [216.151.155.121] ([216.151.155.121]:62473 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S132801AbRDYV6k>; Wed, 25 Apr 2001 17:58:40 -0400
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, tim@tjansen.de,
        linux-kernel@vger.kernel.org
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
In-Reply-To: <01042522404901.00954@cookie>
	<200104252116.QAA46520@tomcat.admin.navo.hpc.mil>
	<20010425235000.A3432@werewolf.able.es>
From: Doug McNaught <doug@wireboard.com>
Date: 25 Apr 2001 17:58:35 -0400
In-Reply-To: "J . A . Magallon"'s message of "Wed, 25 Apr 2001 23:50:00 +0200"
Message-ID: <m34rvcy73o.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" <jamagallon@able.es> writes:

> Question: it is possible to redirect the same fs call (say read) to different
> implementations, based on the open mode of the file descriptor ? So, if
> you open the entry in binary, you just get the number chunk, if you open
> it in ascii you get a pretty printed version, or a format description like

There is no distinction between "text" and "binary" modes on a file
descriptor.  The distinction exists in the C stdio layer, but is a
no-op on Unix systems.

-Doug
-- 
The rain man gave me two cures; he said jump right in,
The first was Texas medicine--the second was just railroad gin,
And like a fool I mixed them, and it strangled up my mind,
Now people just get uglier, and I got no sense of time...          --Dylan
