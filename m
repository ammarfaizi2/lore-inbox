Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTD3HiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 03:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTD3HiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 03:38:05 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:20864 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262115AbTD3HiF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 03:38:05 -0400
Date: Wed, 30 Apr 2003 08:50:04 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: joe briggs <jbriggs@briggsmedia.com>, linux-kernel@vger.kernel.org
Subject: Re: software reset
Message-ID: <20030430075004.GB13859@mail.jlokier.co.uk>
References: <200304291037.13598.jbriggs@briggsmedia.com.suse.lists.linux.kernel> <p73vfwx2uw8.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73vfwx2uw8.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> The most reliable way is to force a triple fault; load zero into
> the IDT register and then trigger an exception. The linux kernel 
> does that in fact for reboot and so far I haven't seen any machine failing
> to reset yet.

There are some 486s which don't boot on triple fault, nor on asking
the keyboard controller to pulse the reset line.  Hence the 3rd option,
"reboot=bios".

-- Jamie
