Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262988AbVFXONN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262988AbVFXONN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 10:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbVFXOM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 10:12:56 -0400
Received: from dvhart.com ([64.146.134.43]:11954 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262905AbVFXOLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 10:11:38 -0400
Date: Fri, 24 Jun 2005 07:11:31 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Message-ID: <51900000.1119622290@[10.10.2.4]>
In-Reply-To: <20050621130344.05d62275.akpm@osdl.org>
References: <208690000.1119330454@[10.10.2.4]><20050620232925.41bded87.akpm@osdl.org><235990000.1119363734@[10.10.2.4]> <20050621130344.05d62275.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andrew Morton <akpm@osdl.org> wrote (on Tuesday, June 21, 2005 13:03:44 -0700):

> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>> 
>> Or I guess it's binary chop
>>  search amongst sched patches (or at least the ones that are new in 
>>  this -mm ?)
> 
> Yes please.

OK, still broken with the last 3 backed out, but works with the last
4 backed out. So I guess it's scheduler-cache-hot-autodetect.patch
that breaks it. Con just sent me something else to try to fix it in order
to run next ... will do that.

M.

