Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUCCQNi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 11:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbUCCQNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 11:13:37 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:48907
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262503AbUCCQNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 11:13:37 -0500
Date: Wed, 3 Mar 2004 17:14:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave McCracken <dmccr@us.ibm.com>
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040303161415.GG4922@dualathlon.random>
References: <20040303070933.GB4922@dualathlon.random> <8030000.1078329278@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8030000.1078329278@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 07:54:39AM -0800, Martin J. Bligh wrote:
> Makes sense. But why would you want 4:4 on opteron? I'm not sure we care
> about the perf for anyone nutty enough to run a 32 bit kernel there ;-)

it would be purerly a theorical benchmark, to see if the current state
of the art technology is hurted more or less by 4:4. If it's hurted less
it's reasonable to assume newer cpus will be hurted less too. However
we'll probably deal with only with a few more generation of 32bit cpus
and it will be only from intel so I agree with you the xeon test is the
most interesting for this.
