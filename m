Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbUC2RfW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUC2RfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:35:21 -0500
Received: from palrel12.hp.com ([156.153.255.237]:47064 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262993AbUC2RfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 12:35:15 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16488.24144.210530.414379@napali.hpl.hp.com>
Date: Mon, 29 Mar 2004 09:35:12 -0800
To: Andi Kleen <ak@suse.de>
Cc: David Mosberger <davidm@napali.hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: replace MAX_MAP_COUNT with /proc/sys/vm/max_map_count
In-Reply-To: <p733c7uak1m.fsf@nielsen.suse.de>
References: <16485.5722.591616.846576@napali.hpl.hp.com.suse.lists.linux.kernel>
	<p733c7uak1m.fsf@nielsen.suse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 27 Mar 2004 07:19:49 +0100, Andi Kleen <ak@suse.de> said:

  Andi> David Mosberger <davidm@napali.hpl.hp.com> writes:

  >> +int sysctl_max_map_count = DEFAULT_MAX_MAP_COUNT;

  Andi> I think it would be better to scale the default by available
  Andi> low mem size.

I don't really care, but if you want this to be memory-dependent,
there would be several other parameters that could/should be memory
dependent as well (e.g., max. number of processes).  In other words,
you'd be opening a can of worms.  Not sure that makes sense fo 2.6.

	--david
