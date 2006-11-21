Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934367AbWKUO4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934367AbWKUO4w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 09:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934370AbWKUO4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 09:56:52 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:50102 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S934367AbWKUO4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 09:56:51 -0500
Date: Tue, 21 Nov 2006 15:53:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Howells <dhowells@redhat.com>
cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] WorkStruct: Typedef the work function prototype 
In-Reply-To: <14330.1164037654@redhat.com>
Message-ID: <Pine.LNX.4.61.0611211553320.17154@yvahk01.tjqt.qr>
References: <4561CC0D.2070900@s5r6.in-berlin.de> 
 <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
 <20061120142718.12685.84850.stgit@warthog.cambridge.redhat.com> 
 <14330.1164037654@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 20 2006 15:47, David Howells wrote:
>Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>
>> > Define a type for the work function prototype.  It's not only kept in the
>> > work_struct struct, it's also passed as an argument to several functions.
>> 
>> If so, it should certainly also be used in the declarations and
>> definitions of the work functions.
>
>Is this what you mean?:
>
>	work_func_t do_my_work
>	{
>		...
>	}

That should not compile.


	-`J'
-- 
