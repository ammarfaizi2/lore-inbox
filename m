Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWEBPaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWEBPaW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWEBPaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:30:22 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:18192 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S964886AbWEBPaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:30:21 -0400
Message-ID: <44577B07.2000105@argo.co.il>
Date: Tue, 02 May 2006 18:30:15 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Al Viro <viro@ftp.linux.org.uk>, Willy Tarreau <willy@w.ods.org>,
       David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <20060502133416.GT27946@ftp.linux.org.uk> <4457668F.8080605@argo.co.il> <20060502143430.GW27946@ftp.linux.org.uk> <445774F7.5030106@argo.co.il> <20060502151525.GX27946@ftp.linux.org.uk> <44577887.7040506@argo.co.il> <45D64E85-41E8-4DBC-B8F9-382DA0AA2F36@mac.com>
In-Reply-To: <45D64E85-41E8-4DBC-B8F9-382DA0AA2F36@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2006 15:30:19.0664 (UTC) FILETIME=[5201C900:01C66DFD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On May 2, 2006, at 11:19:35, Avi Kivity wrote:
>> I wasn't talking about modifying gcc to do the checking, rather using 
>> language features so that the checks would happen during a regular 
>> compile. That would mean we weren't dependent on somebody running 
>> sparse with a configuration that triggers the bug, but those few who 
>> compile the code before submitting the patch would get it 
>> automatically checked.
>
> There's a reason that we tell all patch submitters to run "make C=1" 
> on several configs before submitting patches.  Besides, you seem to 
> have a vast misunderstanding of LK development processes; we frown 
> heavily on people who don't "compile their code before submitting the 
> patch", it's not a rare thing at all.
>

That was tongue in cheek. Perhaps I should have added a smiley.

I follow lkml quite closely, even though I lack the time to contribute 
in the areas that interest me.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

