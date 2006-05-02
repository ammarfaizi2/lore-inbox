Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWEBPva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWEBPva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWEBPva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:51:30 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:64272 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S964895AbWEBPva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:51:30 -0400
Message-ID: <44577FFE.2090009@argo.co.il>
Date: Tue, 02 May 2006 18:51:26 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Willy Tarreau <willy@w.ods.org>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <20060502133416.GT27946@ftp.linux.org.uk> <4457668F.8080605@argo.co.il> <20060502143430.GW27946@ftp.linux.org.uk> <445774F7.5030106@argo.co.il> <20060502151525.GX27946@ftp.linux.org.uk> <44577887.7040506@argo.co.il> <20060502152837.GY27946@ftp.linux.org.uk>
In-Reply-To: <20060502152837.GY27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2006 15:51:28.0101 (UTC) FILETIME=[460DE950:01C66E00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> g++ won't cover all checks sparse is capable of, so you still want to
> run the latter over new code anyway (== pass C=1 to make).  IOW, type
> safety from C++ isn't particulary good argument.
>   
I'm pretty sure that sparse can't validate all the casting from void 
pointers and from "base classes". Nor can it find bugs in data 
structures which are open-coded instead of template libraries. Do 
correct me if I'm wrong.

I'm not familiar with sparse's capabilities beyond __user, locking 
depth, and the like (pulling it now). Can you point me to any information?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

