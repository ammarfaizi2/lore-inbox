Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbTFAUuk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 16:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbTFAUuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 16:50:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37859
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264727AbTFAUuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 16:50:39 -0400
Subject: Re: [PATCH] Modular IDE completely broken
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Taral <taral@taral.net>
Cc: Tomas Szepe <szepe@pinerecords.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030601175138.GA1936@taral.net>
References: <20030601055414.GA11218@taral.net>
	 <20030601113050.GE27692@louise.pinerecords.com>
	 <20030601175138.GA1936@taral.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054497954.5863.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2003 21:05:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-01 at 18:51, Taral wrote:
> On Sun, Jun 01, 2003 at 01:30:50PM +0200, Tomas Szepe wrote:
> > > [taral@taral.net]
> > > 
> > > I've submitted this patch before, but I think it got ignored. This makes
> > > modular IDE at least compile and removes the circular dependencies.
> > > 
> > > If there's a reason this patch isn't being applied (it's crappy, someone
> > > else is working on this problem already, etc.), _please_ tell me!
> > 
> > Alan Cox is working on the problem ATM, check 2.4.21-rc6-ac1.
> 
> Is this work for 2.5 as well? My patch is against 2.5.69.

The same logic applies to 2.5, and it may be more useful there as it can
be used to clean up a pile of other ordering stuff

