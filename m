Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUIIR2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUIIR2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUIIR0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:26:53 -0400
Received: from holomorphy.com ([207.189.100.168]:53425 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266460AbUIIRYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:24:52 -0400
Date: Thu, 9 Sep 2004 10:24:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: Q about pagecache data never written to disk
Message-ID: <20040909172433.GA3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>, Andrey Savochkin <saw@saw.sw.com.sg>,
	linux-kernel@vger.kernel.org
References: <20040905120147.A9202@castle.nmd.msu.ru> <20040905035233.6a6b5823.akpm@osdl.org> <20040905154336.B9202@castle.nmd.msu.ru> <20040905140040.58a5fcdc.akpm@osdl.org> <20040909123957.GB1065@elf.ucw.cz> <41405773.3090403@yahoo.com.au> <20040909133703.GA32038@atrey.karlin.mff.cuni.cz> <41405B51.20705@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41405B51.20705@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 11:32:01PM +1000, Nick Piggin wrote:
> writeback isn't, but the pages will get marked dirty at unmap.
> But I think I am wrong actually - I don't actually see why the
> user would have to have the file open.

Dirty memory "limits" have no force as applied to mmap() IO, which is
not a pretty state of affairs with respect to various attempts the VM
makes at mitigating data structure proliferation associated with dirty
data.


-- wli
