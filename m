Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTLDWcg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTLDWb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:31:58 -0500
Received: from holomorphy.com ([199.26.172.102]:54737 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263632AbTLDWao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:30:44 -0500
Date: Thu, 4 Dec 2003 14:30:32 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Jason Walker <jason_walker@bellsouth.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unable to address 1GB RAM in 2.4.19 or later
Message-ID: <20031204223032.GA8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Jason Walker <jason_walker@bellsouth.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031204181014.QPLW12995.imf20aec.mail.bellsouth.net@debian> <Pine.LNX.4.58.0312041709290.27578@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312041709290.27578@montezuma.fsmlabs.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003, Jason Walker wrote:
>> Both are SMP kernels. The hardware is a Compaq Proliant 5000R, quad pentium pro
>> 200mhz (256k cache models).
>> Any thoughts on this? Is there any other information needed to address this
>> issue? Please let me know what I can do to assist in correcting this bug.

On Thu, Dec 04, 2003 at 05:21:14PM -0500, Zwane Mwaikambo wrote:
> You are using mem= what happens without it? I wonder if mem= is broken
> again.

Both of the BIOS-88 tables match; for some reason 2.4.18 ignored the
fact it was only reporting 16MB. It should see an e820...


-- wli
