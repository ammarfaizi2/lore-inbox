Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWGPWyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWGPWyF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 18:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWGPWyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 18:54:05 -0400
Received: from main.gmane.org ([80.91.229.2]:49605 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751329AbWGPWyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 18:54:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lexington Luthor <Lexington.Luthor@gmail.com>
Subject: Re: "Why Reuser 4 still is not in" doc
Date: Sun, 16 Jul 2006 23:53:46 +0100
Message-ID: <e9eg1v$5sf$1@sea.gmane.org>
References: <20060716161631.GA29437@httrack.com>	 <20060716162831.GB22562@zeus.uziel.local>	 <20060716165648.GB6643@thunk.org> <e9dsrg$jr1$1@sea.gmane.org>	 <20060716174804.GA23114@thunk.org>	 <20060716220115.a1891231.diegocg@gmail.com>	 <e9ea1v$nc4$1@sea.gmane.org> <bda6d13a0607161428j187b737ft6f3925d9a3b2cc72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bb-82-108-13-253.ukonline.co.uk
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
In-Reply-To: <bda6d13a0607161428j187b737ft6f3925d9a3b2cc72@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson wrote:
>> (aside from the VFS integration debate)
> Anybody know what's in Reiser4 that VFS doesn't like (link please)?

Reiser4 plug-ins have (had?) the ability to alter the semantics of 
things, like making files into directories inside which you could see 
meta-files like file/uid and file/size which contained meta-data and 
such accessible as normal files to all the unix tools (which is a very 
good idea IMO). You could get things like chmod by just 'echo root 
 >file/owner' or something, very nice.

This was frowned upon by kernel developers who felt that it belonged in 
the kernel VFS (if at all), rather than in reiser4 directly.

Regards,
LL

