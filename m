Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbTA2FtN>; Wed, 29 Jan 2003 00:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTA2FtN>; Wed, 29 Jan 2003 00:49:13 -0500
Received: from holomorphy.com ([66.224.33.161]:24492 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264790AbTA2FtM>;
	Wed, 29 Jan 2003 00:49:12 -0500
Date: Tue, 28 Jan 2003 21:55:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: colpatch@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [patch][trivial] fix drivers/base/cpu.c
Message-ID: <20030129055547.GL780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>, colpatch@us.ibm.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <3E2F2EC1.4090606@us.ibm.com> <20030129050522.316E32C63F@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129050522.316E32C63F@lists.samba.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E2F2EC1.4090606@us.ibm.com> Matt Dobson (?) wrote:
>> Both drivers/base/node.c & memblk.c check the return values of the 
>> devclass_register & driver_register calls.  cpu.c doesn't.  This little 
>> patch remedies that omission.

On Wed, Jan 29, 2003 at 03:51:04PM +1100, Rusty Russell wrote:
> You'd want to to undo the devclass_register() on failure, too, I
> imagine.

Ow, I forgot about that. Someone grind this out quick and take care of
the other oopsing thingies. You know what I'm preoccupied with.


-- wli
