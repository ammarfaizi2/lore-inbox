Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262675AbSJBWpd>; Wed, 2 Oct 2002 18:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262678AbSJBWpd>; Wed, 2 Oct 2002 18:45:33 -0400
Received: from nl-ams-slo-l4-02-pip-4.chellonetwork.com ([213.46.243.20]:50215
	"EHLO amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262675AbSJBWpc>; Wed, 2 Oct 2002 18:45:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Eriksson Stig <stig.eriksson@sweco.se>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx problems?
Date: Thu, 3 Oct 2002 00:50:56 +0200
X-Mailer: KMail [version 1.3.1]
References: <E50A0EFD91DBD211B9E40008C75B6CCA01497EDD@ES-STH-012> <3901880000.1033578523@aslan.btc.adaptec.com> <3907280000.1033578658@aslan.btc.adaptec.com>
In-Reply-To: <3907280000.1033578658@aslan.btc.adaptec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021002225057.TYEL1314.amsfep11-int.chello.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 19:10, Justin T. Gibbs wrote:
>
> Actually, in reviewing your message more fully, the problem is that
> the timeout for the rewind operation is too short for your configuration.
> The timeout should go away if you bump up the timeout in the st driver
> so that your tape drive can rewind in peace.

I guess there is something seriously wrong in the driver then: my SCSI cdrom 
writers have the same problem. Result: lots of bad CDs.

Jos

