Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272456AbTHKJs3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 05:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272476AbTHKJs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 05:48:29 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:30218 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272456AbTHKJs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 05:48:28 -0400
Date: Mon, 11 Aug 2003 10:48:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: sal@agora.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18/2.4.20 filemap.c pmd bug (was Re: Problem with mm in 2.4.19 and 2.4.20)
Message-ID: <20030811104823.A15144@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Harald Welte <laforge@gnumonks.org>, sal@agora.pl,
	linux-kernel@vger.kernel.org
References: <20030208121633.GB17017@virgin.gazeta.pl> <20030811073443.GA8953@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030811073443.GA8953@sunbeam.de.gnumonks.org>; from laforge@gnumonks.org on Mon, Aug 11, 2003 at 09:34:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 09:34:43AM +0200, Harald Welte wrote:
> >I'm using Linux Debian on dual PIII 1.1Ghz, 1GB RAM, LVM version 1.0.6
> >Qlogic FC 2200F driver version 6.01
> 
> We don't use lvm, so the similarities seem to be:  Dual PIII, 
> SCSI, INN

Well, qlogic + lvm is vert prone of stack overflows.  You're using aic7xxx
I assume?  Some other interesting drivers?

