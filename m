Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWDGFiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWDGFiQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWDGFiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:38:16 -0400
Received: from smtpout.mac.com ([17.250.248.84]:39165 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932274AbWDGFiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:38:15 -0400
In-Reply-To: <bda6d13a0604061909u69dd8453me4c9b96cca8d34f5@mail.gmail.com>
References: <787b0d920604052038i3a75bdb6ic0818d93805b881b@mail.gmail.com> <bda6d13a0604061909u69dd8453me4c9b96cca8d34f5@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <217AB2B7-BD72-49BE-AB02-AA952728073B@mac.com>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: wait4/waitpid/waitid oddness
Date: Fri, 7 Apr 2006 01:38:09 -0400
To: Joshua Hudson <joshudson@gmail.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 6, 2006, at 22:09:48, Joshua Hudson wrote:
> I'm the guy who removed the check in link() about source is a  
> directory, found out what broke, and am working on a patch to fix  
> all the resulting breakage.  Your task is apt to be a lot simpler.

I seem to recall the reason why hardlinking directories was  
prohibited had something more to do with some unfixable races and  
deadlocks in the kernel; not to mention creating self-referential  
directory trees that are never freed and chew up disk space.

Cheers,
Kyle Moffett

