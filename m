Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262739AbTCPT72>; Sun, 16 Mar 2003 14:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262740AbTCPT72>; Sun, 16 Mar 2003 14:59:28 -0500
Received: from holomorphy.com ([66.224.33.161]:57558 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262739AbTCPT71>;
	Sun, 16 Mar 2003 14:59:27 -0500
Date: Sun, 16 Mar 2003 12:10:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] O(1) proc_pid_readdir
Message-ID: <20030316201001.GL20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303161645030.27928-100000@dbl.q-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303161645030.27928-100000@dbl.q-ag.de>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 04:52:48PM +0100, Manfred Spraul wrote:
> Below is a proposal to get rid of the quadratic behaviour of 
> proc_pid_readir(): Instead of storing the task number in f_pos and walking 
> tasks by tasklist order, the pid is stored in f_pos and the tasks are 
> walked by (hash-mangled) pid order.

Looks good to me. Testing soon.


-- wli
