Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbTKKEWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 23:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTKKEWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 23:22:11 -0500
Received: from cafe.hardrock.org ([142.179.182.80]:21131 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S263334AbTKKEWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 23:22:08 -0500
Date: Mon, 10 Nov 2003 21:22:03 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: Joseph Shamash <info@avistor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fibre channel HBA support
In-Reply-To: <HBEHKOEIIJKNLNAMLGAOAEDDDKAA.info@avistor.com>
Message-ID: <Pine.LNX.4.44.0311102114010.11583-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, Joseph Shamash wrote:

> Hello,
> 
> I have been searching for information on fibre channel HBA support for the
> 2.6.0 kernel. I was hoping to use the LSIFC919, but my search seems to
> indicate this driver is not yet supported in the 2.6.0 kernel.
> 
> I did find the HP Fibre Channel HBA is supported. Can anyone please advise
> me about any other Fibre Channel HBA support in the 2.6.0 kernel?

The qlogic HBAs are supported as well and we do use several qla2340
adapters for connecting to our emc SAN.

The driver is not yet included in 2.4.22 at least, but you can find it on
the qlogic site at http://www.qlogic.com/support/product_resources.asp?id=253

We are currently at 6.04-fo (fail over code works very well).

Regards
James Bourne
> 
> Thanks,
> _____________________________________
> Joseph Shamash
> ____________________________________________
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

