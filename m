Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267753AbTAXPic>; Fri, 24 Jan 2003 10:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267757AbTAXPic>; Fri, 24 Jan 2003 10:38:32 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44677 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267753AbTAXPib>;
	Fri, 24 Jan 2003 10:38:31 -0500
Date: Fri, 24 Jan 2003 07:47:37 -0800
From: Dave Olien <dmo@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       markw@osdl.org, cliffw@osdl.org, maryedie@osdl.org, jenny@osdl.org
Subject: Re: [BUG] BUG_ON in I/O scheduler, bugme # 288
Message-ID: <20030124074737.A10818@acpi.pdx.osdl.net>
References: <20030123135448.A8801@acpi.pdx.osdl.net> <20030123143824.4aae1efd.akpm@digeo.com> <20030123143453.A9072@acpi.pdx.osdl.net> <20030124075030.GF910@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030124075030.GF910@suse.de>; from axboe@suse.de on Fri, Jan 24, 2003 at 08:50:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yup, the BUG_ON was in vanilla 2.5.59.  The mm patch still shows
the non-completion issue.

On Fri, Jan 24, 2003 at 08:50:30AM +0100, Jens Axboe wrote:
> 
> I'm assuming vanilla 2.5.59, there's no BUG_ON() in -mm5 that line.
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
