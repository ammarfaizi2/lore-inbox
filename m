Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWH2Pmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWH2Pmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 11:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWH2Pmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 11:42:35 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:9964 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S965034AbWH2Pme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 11:42:34 -0400
Date: Tue, 29 Aug 2006 17:42:35 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: 2.6.18-rc4-mm3
Message-ID: <20060829174235.2da4368b@cad-250-152.norway.atmel.com>
In-Reply-To: <44F45AE2.6000309@fr.ibm.com>
References: <20060826160922.3324a707.akpm@osdl.org>
	<20060829153700.309334d6@cad-250-152.norway.atmel.com>
	<44F45AE2.6000309@fr.ibm.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 17:18:58 +0200
Cedric Le Goater <clg@fr.ibm.com> wrote:

> Haavard Skinnemoen wrote:
> > On Sat, 26 Aug 2006 16:09:22 -0700
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> >> +namespaces-add-nsproxy-move-init_nsproxy-into-kernel-nsproxyc.patch
> > 
> > This causes a multiple definition of init_nsproxy on AVR32.
> > Reverting namespaces-add-nsproxy-avr32-fix.patch fixes it.
> 
> Could you try this ?

Yes, this works fine. This does in fact revert
namespaces-add-nsproxy-avr32-fix.patch, so it would work equally well
to just drop that patch.

Thanks,

Haavard
