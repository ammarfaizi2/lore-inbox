Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751921AbWI3UVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWI3UVV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWI3UVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:21:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39582 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751921AbWI3UVV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:21:21 -0400
Date: Sat, 30 Sep 2006 21:21:17 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Message-ID: <20060930202117.GO29920@ftp.linux.org.uk>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 12:54:21PM -0700, Linus Torvalds wrote:
> We need Al Viro here to put this kind of code into perspective. I _think_ 
> he would have some choice words for code that is meant to "help" 
> debugging, and is this horrible.

Oh, so _that_ is what it is supposed to do?  I've seen it when it went
in, tried to read, barfed and chalked it up to KDB or itanic braindamage
(both have turds of that genre).  Didn't realize that lockdep used it too...
