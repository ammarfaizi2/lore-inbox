Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272949AbTHKRz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272956AbTHKRz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:55:27 -0400
Received: from holomorphy.com ([66.224.33.161]:55465 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272949AbTHKRyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:54:20 -0400
Date: Mon, 11 Aug 2003 10:55:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Cliff White <cliffw@osdl.org>
Subject: Re: [PATCH]O14int
Message-ID: <20030811175531.GF32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin Schlemmer <azarah@gentoo.org>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Cliff White <cliffw@osdl.org>
References: <200308090149.25688.kernel@kolivas.org> <200308091904.19222.kernel@kolivas.org> <1060580691.13254.7.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060580691.13254.7.camel@workshop.saharacpt.lan>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003 01:49, Con Kolivas wrote:
>>> Wli pointed out an error in the nanosecond to jiffy conversion which may
>>> have been causing too easy to migrate tasks on smp (? performance change).

On Sat, 2003-08-09 at 11:04, Con Kolivas wrote:
>> Looks like I broke SMP build with this. Will fix soon; don't bother trying 
>> this on SMP yet.

On Mon, Aug 11, 2003 at 07:44:52AM +0200, Martin Schlemmer wrote:
> Not to be nasty or such, but all these patches have taken
> a very responsive HT box to one that have issues with multiple
> make -j10's running and random jerkyness.
> I am not so sure I for one want changes to the scheduler for
> SMP (not UP interactivity ones anyhow).

Please try this again with the suggested correction to the load balancer.


-- wli
