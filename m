Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267750AbUHJVgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267750AbUHJVgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267740AbUHJVgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:36:09 -0400
Received: from jade.spiritone.com ([216.99.193.136]:59347 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267750AbUHJVfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:35:40 -0400
Date: Mon, 09 Aug 2004 23:31:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.6.8-rc3-mm2
Message-ID: <2724460000.1092119514@[10.10.2.4]>
In-Reply-To: <20040808153804.6daca91b.akpm@osdl.org>
References: <20040808153804.6daca91b.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Added a little patch to the CPU scheduler which disables its array
>   switching.
> 
>   This is purely experimental and will cause high-priority tasks to starve
>   lower-priority tasks indefinitely.  It is here to determine whether it is
>   this aspect of the scheduler which caused the staircase scheduler to exhibit
>   improved throughput in some tests on NUMAq.

Nope, wasn't that. Has the same performance as without staircase.

M.

