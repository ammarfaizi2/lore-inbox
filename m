Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRAYTvW>; Thu, 25 Jan 2001 14:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRAYTvM>; Thu, 25 Jan 2001 14:51:12 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:12043 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129051AbRAYTvI>; Thu, 25 Jan 2001 14:51:08 -0500
Date: Thu, 25 Jan 2001 14:56:12 -0500
From: Chris Mason <mason@suse.com>
To: Ondrej Sury <ondrej@globe.cz>,
        Tim Fletcher <tim@parrswood.manchester.sch.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI error in 2.4.1-pre10 @ via82c686 (Was: 2.4.1-pre10
 slowdown at boot.)
Message-ID: <60340000.980452572@tiny>
In-Reply-To: <874ryn5vhf.fsf@ondrej.office.globe.cz>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, January 25, 2001 07:37:16 PM +0100 Ondrej Sury
<ondrej@globe.cz> wrote:

> I have discovered that it wasn't reiserfs problem.  I have disabled ACPI
> in BIOS and everything is ok.  So I assume that something has changed in
> ACPI between pre9 and pre10 versions and that something is broken in _my_
> system.
> 

Ok.  This isn't related to the slowdown problem you are seeing, but after a
clean shutdown, there should not be any transactions that need replay.
Keep an eye on the console as you shutdown, and make sure / is getting
properly unmounted.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
