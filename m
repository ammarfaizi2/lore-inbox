Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWC3GmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWC3GmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWC3GmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:42:08 -0500
Received: from pproxy.gmail.com ([64.233.166.183]:34619 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750725AbWC3GmH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:42:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TzVk6n3fb3WjTxBr54WevkkWzM7nsCQe4VL+gfE3E8bwkMiUt1lfqfqZYSqrjOVagLkyb1MukANWdEBVLKXGQe+2tIKER47VC0MKtP7FMaafY3x9M3xbOrQ1vt7vBC9Vl9VW31Be83H0mfS2knyRBbwT1SFVbQjj7cFX2nE9phc=
Message-ID: <9305ca410603292242h3bca06b0k15de4855ee5d36@mail.gmail.com>
Date: Thu, 30 Mar 2006 08:42:02 +0200
From: "Peter Korsgaard" <jacmet@sunsite.dk>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: serial/8250: Platform override of is_real_interrupt
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143641573.17522.51.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <8764lxphh8.fsf@sleipner.barco.com>
	 <1143641573.17522.51.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Your hardware platform should be mapping interrupts so that the cookie
> dev->irq is not 0 for a valid IRQ.

Thanks. I'll do that instead then.

--
Bye, Peter Korsgaard
