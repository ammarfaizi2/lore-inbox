Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbUA0P1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 10:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbUA0P1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 10:27:19 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:11472 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264441AbUA0P1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 10:27:18 -0500
Date: Tue, 27 Jan 2004 07:27:11 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU
Message-ID: <368660000.1075217230@[10.10.2.4]>
In-Reply-To: <361670000.1075187987@[10.10.2.4]>
References: <20040127024049.7B90B2C13D@lists.samba.org> <356230000.1075178284@[10.10.2.4]> <4015F9A8.6000801@cyberone.com.au> <361670000.1075187987@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, I talked it over with Rusty some on IRC. I have more of a feeling
> why he's trying to do it that way now. 

BTW, Rusty - what are the locking rules for cpu_online_map under hotplug?
Is it RCU or something? The sched domains usage of it doesn't seem to take 
any locks.

M.

