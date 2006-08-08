Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWHHSFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWHHSFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWHHSFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:05:01 -0400
Received: from accolon.hansenpartnership.com ([64.109.89.108]:932 "EHLO
	accolon.hansenpartnership.com") by vger.kernel.org with ESMTP
	id S964960AbWHHSFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:05:00 -0400
Subject: Re: PATCH: Voyager, tty locking
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44D8D073.5080505@oracle.com>
References: <1155060469.5729.109.camel@localhost.localdomain>
	 <44D8D073.5080505@oracle.com>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 13:04:48 -0500
Message-Id: <1155060288.26517.43.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 10:57 -0700, Zach Brown wrote:
> > The signal handling also appears to be incorrect as it does an
> > unprotected sigfillset that also appears unneccessary. As I don't have a
> > bowtie and am therefore not a qualified voyager maintainer I leave that
> > to James.
> 
> Bowtie or not, you touched it last!
> 
> This seems like a decent candidate for being moved over to the kthread API..

Alan's patch looks fine so you can add my ack to it (and that of my
bowtie).

I'll add the kthread conversion to my list ... unless the suggestor also
wants to become the implementor?

James


