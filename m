Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbUDGQuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUDGQuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:50:20 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:35812 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263762AbUDGQuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:50:15 -0400
Message-ID: <40743110.8000306@nortelnetworks.com>
Date: Wed, 07 Apr 2004 12:49:20 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Paul Wagland <paul@wagland.net>, linux-kernel@vger.kernel.org,
       gktnews@gktech.net
Subject: Re: amd64 questions
References: <1Ijzw-4ff-5@gated-at.bofh.it> <1Ijzv-4ff-3@gated-at.bofh.it>	<1IntE-7wn-39@gated-at.bofh.it> <m3isgb69xx.fsf@averell.firstfloor.org>
In-Reply-To: <m3isgb69xx.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> The problem is always the long long alignment. AMD64/IA64 have different
> alignment for long long than i386. The emulation was originally tested
> on some RISC port, where the alignment is the same.

What about a compiler flag to emit i386 code with the more strenuous 
long long alignment?

Chris
