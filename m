Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWEBPTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWEBPTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWEBPTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:19:41 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:60687 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S964878AbWEBPTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:19:41 -0400
Message-ID: <44577887.7040506@argo.co.il>
Date: Tue, 02 May 2006 18:19:35 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Willy Tarreau <willy@w.ods.org>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <20060502133416.GT27946@ftp.linux.org.uk> <4457668F.8080605@argo.co.il> <20060502143430.GW27946@ftp.linux.org.uk> <445774F7.5030106@argo.co.il> <20060502151525.GX27946@ftp.linux.org.uk>
In-Reply-To: <20060502151525.GX27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2006 15:19:39.0226 (UTC) FILETIME=[D446B3A0:01C66DFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Tue, May 02, 2006 at 06:04:23PM +0300, Avi Kivity wrote:
>   
>> BTW, C++ could take over some of sparse's function:
>>     
>
> And the point of that would be?  sparse is _fast_ and easy to modify;
> g++ is neither.
>   

I wasn't talking about modifying gcc to do the checking, rather using 
language features so that the checks would happen during a regular 
compile. That would mean we weren't dependent on somebody running sparse 
with a configuration that triggers the bug, but those few who compile 
the code before submitting the patch would get it automatically checked.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

