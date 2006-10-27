Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWJ0V6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWJ0V6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWJ0V6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:58:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:1028 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750723AbWJ0V6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:58:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=oApg+GxOky6tkzR5meqzl3wiiRL6E60v3bydM7Y81ClzctQqEe7ONNyLFGccQEQzXRwZN1HdjF5OTdJSHxH7dMsFV37hUhGf5ZUFiQG3b1K7AkbwdchkGHUfDMjDK5l5sE27QZw2J8VL1qDODjDAETrjorhxmH8PI0jUqiLLCzE=
Date: Fri, 27 Oct 2006 22:58:43 +0100
From: Friedrich =?iso-8859-1?Q?G=F6pel?= <shado23@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061027215843.GA11614@localhost.ntlworld.com>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <1161969308.27225.120.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1161969308.27225.120.camel@mindpipe>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:15 Fri 27 Oct     , Lee Revell wrote:
> Someone recently pointed out to me that a Windows "CPU driver update"
> supplied by AMD fixes the unsynced TSC problem on dual core AMD64
> systems.
> 
...
> What are the chances of Linux getting a similar fix?
> 
> Lee
> 

Hi,

This post earlier seems to suggest someone is indeed working on
something similar, if I'm understanding this correctly:
http://lkml.org/lkml/2006/10/27/27

quote:
> Jiri Bohac (jbohac@suse.cz) is currently working on a new timekeeping code for
> x86-64 that takes a significantly different approach that allows for
> precise and fast gettimeofday even on CPUs with unsynchronized TSCs.

Cheers,

Friedrich Göpel
