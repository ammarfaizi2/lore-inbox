Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262770AbTCJIsb>; Mon, 10 Mar 2003 03:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262822AbTCJIsa>; Mon, 10 Mar 2003 03:48:30 -0500
Received: from holomorphy.com ([66.224.33.161]:28852 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262770AbTCJIs3>;
	Mon, 10 Mar 2003 03:48:29 -0500
Date: Mon, 10 Mar 2003 00:57:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: mbligh@aracnet.com, gone@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64bk5: X86_PC + HIGHMEM boot failure
Message-ID: <20030310085754.GC20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Adam J. Richter" <adam@yggdrasil.com>, mbligh@aracnet.com,
	gone@us.ibm.com, linux-kernel@vger.kernel.org
References: <200303100846.AAA09348@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303100846.AAA09348@baldur.yggdrasil.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Mar 2003, Martin J. Bligh wrote:
>> changes are in my tree ...  I've just checked it, and it doesn't 
>> do that for me. It should *allow* you to turn on CONFIG_NUMA 
>> (and that might be broken for PCs still) but it shouldn't be on 
>> by default ... could you check that you can still disable it?
>> Works for me ...

On Mon, Mar 10, 2003 at 12:46:05AM -0800, Adam J. Richter wrote:
> 	Oops.  You're right it is possible to deactivate
> CONFIG_NUMA in this kernel under X86_PC, and that avoids
> the problem.  I guess there still is the minor issue that
> either CONFIG_NUMA should work with X86_PC + HIGHMEM (even
> on machines without high memory) or else CONFIG_NUMA
> should not be selectable in this case, but that's obviously
> a bug of much less importance.
> 	Sorry for my misunderstanding of the CONFIG_NUMA configution
> options.

It might help if we could get bootlogs or backtraces from you.


-- wli
