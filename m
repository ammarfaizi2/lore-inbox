Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTEHMRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTEHMRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:17:13 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:30724 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261449AbTEHMRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:17:02 -0400
Date: Thu, 8 May 2003 13:29:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Terje Malmedal <terje.malmedal@usit.uio.no>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Terje Eggestad <terje.eggestad@scali.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       D.A.Fedorov@inp.nsk.su
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030508132931.A4951@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Terje Malmedal <terje.malmedal@usit.uio.no>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Terje Eggestad <terje.eggestad@scali.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	D.A.Fedorov@inp.nsk.su
References: <1052122784.2821.4.camel@pc-16.office.scali.no> <20030505092324.A13336@infradead.org> <1052127216.2821.51.camel@pc-16.office.scali.no> <1052133402.29361.2.camel@dhcp22.swansea.linux.org.uk> <E19DkT9-0000Wh-00@aqualene.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E19DkT9-0000Wh-00@aqualene.uio.no>; from terje.malmedal@usit.uio.no on Thu, May 08, 2003 at 02:25:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 02:25:51PM +0200, Terje Malmedal wrote:
> 
> EXPORT_SYMBOL_GPL_AND_DONT_EVEN_THINK_ABOUT_SENDING_A_BUG_REPORT(sys_call_table);
> 
> and displaying a nasty warning message on the console whenever a
> module used it?

What about just adding the EXPORT_SYMBOL() yourself yo your kernels
if you think you need it so badly because you can't screw yourself
enough without it?

