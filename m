Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWFBPg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWFBPg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 11:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWFBPg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 11:36:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42116 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932336AbWFBPg1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 11:36:27 -0400
Subject: Re: 2.6.17-rc5-mm2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com>
	 <20060601183836.d318950e.akpm@osdl.org>
	 <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Jun 2006 16:51:02 +0100
Message-Id: <1149263463.11429.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-06-02 at 06:14 -0700, Barry K. Nathan wrote:
> (Ingo, I got your e-mail too, and I will reply to it once I've
> followed your instructions.)
> 
> On 6/1/06, Andrew Morton <akpm@osdl.org> wrote:
> > Damn, sorry.  LLC is completely borked.  You should emphatically set
> > CONFIG_LLC=n.
> 
> Just one problem with that...
> 
> config ATALK
>         tristate "Appletalk protocol support"
>         select LLC

Strange. ATALK doesn't need 802.2LLC, merely SNAP.

Alan

