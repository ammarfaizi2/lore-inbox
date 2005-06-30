Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbVF3RfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbVF3RfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 13:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVF3RfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 13:35:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13193 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262841AbVF3RfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 13:35:01 -0400
Subject: RE: page allocation/attributes question (i386/x86_64 specific)
From: Arjan van de Ven <arjan@infradead.org>
To: Stuart_Hayes@Dell.com
Cc: ak@suse.de, riel@redhat.com, andrea@suse.dk, linux-kernel@vger.kernel.org
In-Reply-To: <B1939BC11A23AE47A0DBE89A37CB26B407434B@ausx3mps305.aus.amer.dell.com>
References: <B1939BC11A23AE47A0DBE89A37CB26B407434B@ausx3mps305.aus.amer.dell.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 19:34:52 +0200
Message-Id: <1120152893.3181.74.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-30 at 11:56 -0500, Stuart_Hayes@Dell.com wrote:
> Andi Kleen wrote:
> > 
> > I only fixed it for x86-64 correct. Does it work for you on x86-64?
> > 
> > If yes then the changes could be brought over.
> > 
> > What do you all need is for anyways?
> > 
> > -Andi
> 
> We need this because the NVidia driver uses change_page_attr() to make
> pages non-cachable, which is causing systems to spontaneously reboot
> when it gets a page that's in the first 8MB of memory.
> 

that's not a linux problem since there isn't really a linux driver that
does this ;)


