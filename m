Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbUKSMRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbUKSMRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUKSMO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:14:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5037 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261384AbUKSMNC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:13:02 -0500
Message-ID: <419DE33E.2000208@pobox.com>
Date: Fri, 19 Nov 2004 07:12:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
References: <20041119005117.GM4943@stusta.de> <20041119085132.GB26231@wotan.suse.de> <419DC922.1020809@pobox.com> <20041119103418.GB30441@wotan.suse.de> <1100863700.21273.374.camel@baythorne.infradead.org> <20041119115539.GC21483@wotan.suse.de> <1100865050.21273.376.camel@baythorne.infradead.org> <20041119120549.GD21483@wotan.suse.de>
In-Reply-To: <20041119120549.GD21483@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I don't know details about the driver, but it's not enabled on x86-64 
> because x86-64 doesn't have ISA set.


which I disagree with.  CONFIG_ISA should include southbridge devices 
behind a PCI<->ISA bridge.  There is zero value to a more stricter 
"there is a physical ISA bus in this machine" definition.

	Jeff


