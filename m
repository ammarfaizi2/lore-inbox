Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268078AbUHQDKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268078AbUHQDKE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 23:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268081AbUHQDKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 23:10:04 -0400
Received: from holomorphy.com ([207.189.100.168]:56235 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268078AbUHQDKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 23:10:00 -0400
Date: Mon, 16 Aug 2004 20:09:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <20040817030957.GI11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <20040817030748.GH11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817030748.GH11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 02:37:10PM -0700, Andrew Morton wrote:
>> - This kernel probably still has the ia64 scheduler startup bug, although it
>>   works For Me.

On Mon, Aug 16, 2004 at 08:07:48PM -0700, William Lee Irwin III wrote:
> AIUI that was fixed by kill-clone-idletask-fix.patch

How did you compile on ia64? I get:

make: *** No rule to make target `.tmp_kallsyms3.S', needed by `.tmp_kallsyms3.o'.  Stop.


-- wli
