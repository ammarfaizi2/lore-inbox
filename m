Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319096AbSIJKnR>; Tue, 10 Sep 2002 06:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319098AbSIJKnR>; Tue, 10 Sep 2002 06:43:17 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:13516 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319096AbSIJKnQ>; Tue, 10 Sep 2002 06:43:16 -0400
Date: Tue, 10 Sep 2002 12:30:47 +0200
From: Heinz.Mauelshagen@t-online.de (Heinz J . Mauelshagen)
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020910123047.A21509@sistina.com>
Reply-To: mauelshagen@sistina.com
References: <20020909104944.GH27887@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020909104944.GH27887@marowsky-bree.de>; from lmb@suse.de on Mon, Sep 09, 2002 at 12:49:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 12:49:44PM +0200, Lars Marowsky-Bree wrote:
> Morning everyone,
> 
> I hope people are waking up by now ;-)
> 
> So, what is the take on "multi-path IO" (in particular, storage) in 2.5/2.6?
> 
> Right now, we have md multipathing in 2.4 (+ an enhancement to that one by
> Jens Axboe and myself, which however was ignored on l-k ;-), an enhancement to
> LVM1 and various hardware-specific and thus obviously wrong approaches.
> 
> I am looking at what to do for 2.5. I have considered porting the small
> changes from 2.4 to md 2.5. The LVM1 changes are probably and out gone, as
> LVM1 doesn't work still.
> 
> I noticed that EVMS duplicates the entire md layer internally (great way to
> code, really!), so that might also require changing if I update the md code.
> 
> Or can the LVM2 device-mapper be used to do that more cleanly?

We have a multi-path target for device-mapper planned for later this year.

This will be a multi-path addon to the generic mapping service(s)
device-mapper already provides which can multi-path access to any
arbitrary given block device, not just logical volumes.

> 
> I wonder whether anyone has given this some thought already.

We did ;)

> 
> 
> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>
> 
> -- 
> Immortality is an adequate definition of high availability for me.
> 	--- Gregory F. Pfister
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

Regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
