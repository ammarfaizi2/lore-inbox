Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWBUNuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWBUNuB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 08:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWBUNuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 08:50:01 -0500
Received: from ns1.suse.de ([195.135.220.2]:30168 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030283AbWBUNuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 08:50:01 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: softlockup interaction with slow consoles
References: <20060220.131847.25386315.davem@davemloft.net>
	<Pine.LNX.4.58.0602210404330.3092@devserv.devel.redhat.com>
	<20060221.011650.120896368.davem@davemloft.net>
From: Andi Kleen <ak@suse.de>
Date: 21 Feb 2006 14:49:49 +0100
In-Reply-To: <20060221.011650.120896368.davem@davemloft.net>
Message-ID: <p73mzgk4y9u.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> writes:

> From: Ingo Molnar <mingo@redhat.com>
> Date: Tue, 21 Feb 2006 04:09:58 -0500 (EST)
> 
> > i changed soft lockup detection to be turned off during bootup. That
> > should work around any boot-time warnings.
> 
> Excellent.


Still you could probably see problems with very slow consoles even after
bootup, couldn't you?

(for some reason some people still use 9600 baud serial consoles, which
tend to trigger all kind of interesting races) 


-Andi
