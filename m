Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265575AbTFZMZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 08:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265579AbTFZMZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 08:25:10 -0400
Received: from 65-124-64-15.rdsl.ktc.com ([65.124.64.15]:18817 "EHLO
	csi.csimillwork.com") by vger.kernel.org with ESMTP id S265575AbTFZMZH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 08:25:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: Oleg Drokin <green@namesys.com>
Subject: Re: AMD MP, SMP, Tyan 2466, REISERFS I/O error
Date: Thu, 26 Jun 2003 09:37:33 -0400
User-Agent: KMail/1.4.3
Cc: Edward Tandi <ed@efix.biz>, Timothy Miller <miller@techsource.com>,
       reiser@namesys.com, Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
References: <BB1F47F5.17533%kernel@mousebusiness.com> <200306260825.54076.jbriggs@briggsmedia.com> <20030626115525.GA13194@namesys.com>
In-Reply-To: <20030626115525.GA13194@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306260937.33463.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 June 2003 07:55 am, Oleg Drokin wrote:

>
> Is not this is one of those heavy-PCI loaded boxes that ocasionally corrupt
> data when PCI is overloaded?

I was curious that I did not get a corresponding driver error such as "lost 
irq" or "interrupted dma" or something like that on the drive.  BTW, it was 
the system (hda) drive that was corrupted.

> The log you quoted shows that suddenly tree nodes have incorrect content
> (and the i/o error is because reiserfs does not know what to do with such
> nodes). (and we hope to push the patch that will print device where error
> have occured soon).
>
> Bye,
>     Oleg

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
