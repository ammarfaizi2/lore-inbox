Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTKRNsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTKRNmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:42:31 -0500
Received: from ns.suse.de ([195.135.220.2]:59857 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262707AbTKRNmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:42:17 -0500
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: syscall numbers larger than 255?
References: <3FAFB081.3090900@nortelnetworks.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Nov 2003 16:54:10 +0100
In-Reply-To: <3FAFB081.3090900@nortelnetworks.com.suse.lists.linux.kernel>
Message-ID: <p73d6c0rzh9.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> writes:

> Just a quick and simple question for someone that knows the answer.
> 
> Stock 2.4.20 for i386 uses syscalls up to 252.  I want to add about a
> half-dozen new syscalls (forward porting stuff that we've got on
> 2.4.18).
> 
> Does x86 support syscall numbers > 255?  If yes, do I have to do
> anything special to use them? If not, what are my options?

They should work fine on x86.

-Andi
