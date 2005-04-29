Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVD2RHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVD2RHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 13:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVD2RHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 13:07:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:58303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262838AbVD2RHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 13:07:43 -0400
Date: Fri, 29 Apr 2005 10:09:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Sean <seanlkml@sympatico.ca>, linux-kernel <linux-kernel@vger.kernel.org>,
       git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
In-Reply-To: <20050429163705.GU21897@waste.org>
Message-ID: <Pine.LNX.4.58.0504291006450.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1>
 <20050429074043.GT21897@waste.org> <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
 <20050429163705.GU21897@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Apr 2005, Matt Mackall wrote:
> 
> That's because no one paid attention until I posted performance
> numbers comparing it to git! Mercurial's goals are:
> 
> - to scale to the kernel development process
> - to do clone/pull style development
> - to be efficient in CPU, memory, bandwidth, and disk space
>   for all the common SCM operations
> - to have strong repo integrity

Ok, sounds good. Have you looked at how it scales over time, ie what 
happens with files that have a lot of delta's?

Let's see how these things work out..

		Linus
