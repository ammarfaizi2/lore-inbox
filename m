Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265156AbTLKQkz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 11:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbTLKQkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 11:40:55 -0500
Received: from holomorphy.com ([199.26.172.102]:39910 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265156AbTLKQky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 11:40:54 -0500
Date: Thu, 11 Dec 2003 08:40:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
Message-ID: <20031211164049.GK8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Anton Blanchard <anton@samba.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Mark Wong <markw@osdl.org>
References: <20031211115222.GC8039@holomorphy.com> <3FD86C70.5000408@cyberone.com.au> <20031211132301.GD8039@holomorphy.com> <3FD8715F.9070304@cyberone.com.au> <20031211133207.GE8039@holomorphy.com> <3FD88D93.3000909@cyberone.com.au> <20031211153838.GH8039@holomorphy.com> <3FD89284.2090509@cyberone.com.au> <20031211155611.GI8039@holomorphy.com> <3FD89D43.7020403@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD89D43.7020403@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 03:37:23AM +1100, Nick Piggin wrote:
> I think there shouldn't be a loop - remember the lock section.

The lock section is irrelevant, but the 1: label isn't actually
behind a jump, so it must be rwsem_wake() or just frequently called.


-- wli
