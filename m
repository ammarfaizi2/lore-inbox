Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270437AbUJUSMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270437AbUJUSMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270782AbUJUSLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:11:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:14778 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S270773AbUJUSCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:02:23 -0400
Message-ID: <4177F774.7000207@osdl.org>
Date: Thu, 21 Oct 2004 10:52:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: bksvn?
References: <pan.2004.10.21.05.35.26.253908@triplehelix.org>
In-Reply-To: <pan.2004.10.21.05.35.26.253908@triplehelix.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:
> Hi all,
> 
> Whatever happened to bksvn? I'm now using Subversion on a daily basis and
> remembered about this neat hack, but...
> 
> % svn ls svn://kernel.bkbits.net/linux-2.5 
> svn: Can't connect to host 'kernel.bkbits.net': Connection refused
> 
> Has it gone elsewhere, or were other problems exposed?

In July/2004, Peter Anvin wrote:

Followup to:  <20040718201014.GA8291@admingilde.org>
By author:    Martin Waitz
In newsgroup: linux.dev.kernel
 >
 > hi :)
 >
 > On Sun, Jul 18, 2004 at 11:18:56AM +0200, Kasper Sandberg wrote:
 > > they are using bitkeeper
 >
 > sure, but Larry announced the CVS gateway some months ago...
 > now that I wanted to give it a try, it doesn't exist anymore :(
 >

Just rsync the CVS repository from:

rsync://rsync.kernel.org/pub/scm/linux/kernel/bkcvs/

The direct access to the repository was removed due to disuse and
security problems.  The rsync is a lot nicer anyway.

	-hpa

-- 
~Randy
