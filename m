Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUA3RIN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbUA3RIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:08:13 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:42980 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S262569AbUA3RIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:08:00 -0500
Message-ID: <401A8F68.60904@backtobasicsmgmt.com>
Date: Fri, 30 Jan 2004 10:07:52 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs sparse file failure in glibc "make check"
References: <Pine.LNX.4.44.0401301552470.1441-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0401301552470.1441-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> I ought to fix this, but I'm averse to complexity.  I'll mull over
> the options before fixing it: please don't hold your breath.

No problem, as I said I have a workaround that causes me no pain. It 
seems that the use of tmpfs for both a traditional filesystem _and_ 
shmem is what's the root of this problem, what is the real advantage of 
both functions being performed by the same code?

