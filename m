Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUHDCUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUHDCUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267218AbUHDCUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:20:25 -0400
Received: from holomorphy.com ([207.189.100.168]:52408 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264917AbUHDCUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:20:20 -0400
Date: Tue, 3 Aug 2004 19:20:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040804022012.GJ2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
	Chris Wright <chrisw@osdl.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20040804015350.GS2241@dualathlon.random> <Pine.LNX.4.44.0408032157160.5948-100000@dhcp83-102.boston.redhat.com> <20040804021332.GT2241@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040804021332.GT2241@dualathlon.random>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 10:01:12PM -0400, Rik van Riel wrote:
>> Nope, Arjan's patch (and my incremental) touch hugetlb_zero_setup,
>> which only seems to be called from ipc/shm.c
>> Normal hugetlb file creation (through the filesystem) isn't touched
>> by these patches.

On Wed, Aug 04, 2004 at 04:13:32AM +0200, Andrea Arcangeli wrote:
> it is:

hugetlb_zero_setup() is only used for shm last I checked.


-- wli
