Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbUCZMEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 07:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbUCZMEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 07:04:15 -0500
Received: from holomorphy.com ([207.189.100.168]:7820 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264023AbUCZMEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 07:04:07 -0500
Date: Fri, 26 Mar 2004 04:03:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: Re: swsusp with highmem, testing wanted
Message-ID: <20040326120359.GW791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
References: <20040324235702.GA497@elf.ucw.cz> <20040325100339.GN791@holomorphy.com> <20040325215919.GA301@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325215919.GA301@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> I think this kind of thing should help stabilize swsusp in the presence
>> of memory holes, which can be important for embedded devices which would
>> in the future find swsusp useful for power-saving purposes.

On Thu, Mar 25, 2004 at 10:59:19PM +0100, Pavel Machek wrote:
> I had to apply this to compile it, I have not ran it yet.

Looks like I had a gaffe or two in there. Let me know if there's any
trouble running it. The thing was meant to be equivalent to the prior
code on ia32, and to avoid some pfn <-> page conversion issues that
matter on other systems.


-- wli
