Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271215AbTGWSqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271220AbTGWSqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:46:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52628 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271215AbTGWSqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:46:13 -0400
Date: Wed, 23 Jul 2003 11:58:58 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [bernie@develer.com: Kernel 2.6 size increase]
Message-Id: <20030723115858.75068294.davem@redhat.com>
In-Reply-To: <20030723195504.A27656@infradead.org>
References: <20030723195355.A27597@infradead.org>
	<20030723195504.A27656@infradead.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 19:55:04 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jul 23, 2003 at 07:53:55PM +0100, Christoph Hellwig wrote:
> > I think this is not only of interest fir the uClinux folks..
> 
> Sorry, this actually already Cc'ed lkml :)  Still the netdev folks
> should read it, too.

Well, we gained some code and a little bit of data, but
the BSS was cut in half which I think deserves noticing :-)

Also, he should analyze the amount of code that actually
gets executed for various tasks, comparing 2.4.x to 2.5.x

I'd take a half-meg code size hit if it meant that all
the normal code paths got cut in half :-)
