Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUCZMgw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 07:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264051AbUCZMgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 07:36:52 -0500
Received: from holomorphy.com ([207.189.100.168]:18316 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264045AbUCZMgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 07:36:50 -0500
Date: Fri, 26 Mar 2004 04:36:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: Re: swsusp with highmem, testing wanted
Message-ID: <20040326123648.GY791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
References: <20040324235702.GA497@elf.ucw.cz> <20040325100339.GN791@holomorphy.com> <20040325215919.GA301@elf.ucw.cz> <20040326120359.GW791@holomorphy.com> <20040326120857.GB3102@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326120857.GB3102@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Looks like I had a gaffe or two in there. Let me know if there's any
>> trouble running it. The thing was meant to be equivalent to the prior
>> code on ia32, and to avoid some pfn <-> page conversion issues that
>> matter on other systems.

On Fri, Mar 26, 2004 at 01:08:57PM +0100, Pavel Machek wrote:
> Well, you forgot to dd chunk_size -1 to zone_pfn, too, and that took
> me a while to find. Here's the final patch, and that one seems to work
> okay.

Looks like more than one or two. Sorry if I ended up burning up time on
your end. But thanks for taking the changes and fixing them up.


-- wli
