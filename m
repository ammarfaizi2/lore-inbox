Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVETANo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVETANo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 20:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVETANn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 20:13:43 -0400
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:36800 "EHLO
	mail25.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S261298AbVETABd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 20:01:33 -0400
Message-Id: <6.2.1.2.0.20050519175715.04665450@no.incoming.mail>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.1.2
Date: Thu, 19 May 2005 18:01:19 -0600
To: "J.A. Magallon" <jamagallon@able.es>
From: Jeff Woods <Kazrak+kernel@cesmail.net>
Subject: Re: Illegal use of reserved word in system.h
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1116544229l.2940l.2l@werewolf.able.es>
References: <20050518195337.GX5112@stusta.de>
 <6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
 <20050519112840.GE5112@stusta.de>
 <Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
 <1116505655.6027.45.camel@laptopd505.fenrus.org>
 <428CCD19.6030909@candelatech.com>
 <428CCE87.2010308@nortel.com>
 <428CCFA7.6010206@candelatech.com>
 <jeacmqg8ww.fsf@sykes.suse.de>
 <1116541832l.2940l.1l@werewolf.able.es>
 <20050519234126.A31656@flint.arm.linux.org.uk>
 <1116544229l.2940l.2l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 5/19/2005 23:10 +0000, J.A. Magallon wrote:
>But the interesting part would be how to know at runtime on what processor 
>I'm running. Will have to look at x86info...

This statement is semantically void.  If you were given a hypothetical 
current_proc_id() function that would tell you, because a userland process 
can (and normally *will*) be rescheduled at any time from one processor to 
another, by the time the hypothetical function returns it's answer it may 
be incorrect.  What use would that be?

--
Jeff Woods <kazrak+kernel@cesmail.net> 

