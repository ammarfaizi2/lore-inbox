Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUGHTkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUGHTkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 15:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbUGHTkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 15:40:06 -0400
Received: from holomorphy.com ([207.189.100.168]:59110 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262328AbUGHTkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 15:40:03 -0400
Date: Thu, 8 Jul 2004 12:39:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Osterlund <petero2@telia.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
Message-ID: <20040708193956.GO21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Osterlund <petero2@telia.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au> <20040708023001.GN21066@holomorphy.com> <m2briq7izk.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2briq7izk.fsf@telia.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:
>> Heh, one goes in while I'm not looking, and look what happens.

On Thu, Jul 08, 2004 at 02:59:11PM +0200, Peter Osterlund wrote:
> Actually, the failure is caused by this change:
> http://linux.bkbits.net:8080/linux-2.5/cset@40db004cKFYB35xMHcRXNijl81BLag?nav=index.html|ChangeSet@-3w
> It only fails when /proc/sys/vm/laptop_mode is 1.

Oh, then I'm stuck in the GFP_WIRED quagmire after all. I guess since
fixing it involves adding lines I'm in deep trouble.


-- wli
