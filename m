Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVFGLwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVFGLwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVFGLwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:52:41 -0400
Received: from ns.suse.de ([195.135.220.2]:10904 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261831AbVFGLwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:52:31 -0400
Message-ID: <42A58A6B.3080301@suse.de>
Date: Tue, 07 Jun 2005 13:52:11 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Karsten Keil <kkeil@suse.de>
Subject: Re: [PATCH] fix tulip suspend/resume
References: <20050606224645.GA23989@pingi3.kke.suse.de> <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Jeff, 
>  this looks ok, but I'll leave the decision to you. Things like this often 
> break.
> 
> Andrew, maybe at least a few days in -mm to see if there's some outcry?

This is a good idea.
This one was broken for a real long time, so some more days cannot hurt ;-)
IIRC it only happened on cardbus cards (but i may have been just lucky)
which you can just pull out and put back in again after resume.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
