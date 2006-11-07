Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932798AbWKGSBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932798AbWKGSBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932797AbWKGSBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:01:18 -0500
Received: from mx.pathscale.com ([64.160.42.68]:1471 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932798AbWKGSBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:01:18 -0500
Message-ID: <4550C9ED.9050308@serpentine.com>
Date: Tue, 07 Nov 2006 10:01:17 -0800
From: "Bryan O'Sullivan" <bos@serpentine.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       olson@pathscale.com
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>	<20061105064801.GV13381@stusta.de>	<m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>	<20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com>	<m1psbzbpxw.fsf@ebiederm.dsl.xmission.com>	<4550B22C.1060307@serpentine.com> <m18xinb1qn.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18xinb1qn.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> If you really need to write to both the config space registers and your
> magic shadow copy of the register I can certainly do the config space
> writes for you.  I just figured it would be more efficient not to.

Yes, we need to do both.

I've got code that refactors your patch a little as I try to get the 
driver happy, but so far it's not seeing any interrupts.  I'll keep you 
posted.

	<b
