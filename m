Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbTLFNH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 08:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbTLFNH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 08:07:29 -0500
Received: from holomorphy.com ([199.26.172.102]:33238 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265155AbTLFNH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 08:07:28 -0500
Date: Sat, 6 Dec 2003 05:07:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mika Penttil? <mika.penttila@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Numaq in 2.4 and 2.6
Message-ID: <20031206130724.GR8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mika Penttil? <mika.penttila@kolumbus.fi>,
	linux-kernel@vger.kernel.org
References: <3FD1A54F.101@kolumbus.fi> <20031206112348.GP8039@holomorphy.com> <3FD1C94C.1020104@kolumbus.fi> <20031206123622.GQ8039@holomorphy.com> <3FD1D4F6.7000106@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD1D4F6.7000106@kolumbus.fi>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 03:09:10PM +0200, Mika Penttil? wrote:
> and later in same function :
> phys_cpu_present_map |= apicid_to_phys_cpu_present(m->mpc_apicid);
> but _not_
> phys_cpu_present_map |= apicid_to_phys_cpu_present(logical_apicid);
> as one would expect (and would make it identical to 2.6 behaviour).... A 
> bug?

You may very well have just debugged an issue I've had with 2.4 on
the things. =)


-- wli
