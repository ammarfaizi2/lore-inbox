Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbTCJT2k>; Mon, 10 Mar 2003 14:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbTCJT2k>; Mon, 10 Mar 2003 14:28:40 -0500
Received: from h-64-105-35-31.SNVACAID.covad.net ([64.105.35.31]:21396 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261421AbTCJT2h>; Mon, 10 Mar 2003 14:28:37 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 10 Mar 2003 11:39:11 -0800
Message-Id: <200303101939.LAA05514@adam.yggdrasil.com>
To: mbligh@aracnet.com
Subject: Re: 2.5.64bk5: X86_PC + HIGHMEM boot failure
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003, Martin J. Bligh wrote:

>> 	I just verified that the problem also occurs with NUMA +
>> HIGHMEM_64GB (i.e., it is not limited to HIGHMEM_4GB).
>> 
>> 	By the way, HIGHMEM_64GB without NUMA gets a lot father, but
>> still experiences memory corruption, probably same bug that caused me
>> to downgrade to HIGHMEM_4G months ago (i.e., probably not related to
>> this NUMA problem).

>Yeah, we really ought to fix that. This one?
> http://bugme.osdl.org/show_bug.cgi?id=5

	Yes.  Thank you for doing such meticulous job of entering it
into bugmse.osdl.org.

[About the original problem of CONFIG_NUMA bombing out on my
384MB machine with a HIGHMEM4G kernel:]
>Right ... I think I have some more patches from Andy somewhere, though
>he may not have tested with 64Gb on his PC ... I'll go look, and send
>them to you if I have.

	Great, although it will probably be several hours before I can
test any patches that you send me.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
