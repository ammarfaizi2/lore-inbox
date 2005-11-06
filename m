Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVKFI5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVKFI5M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVKFI5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:57:12 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:36574 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932342AbVKFI5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 03:57:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=H5OJ2eNq5hVbxbl8BU22XpfwxgIMS3La6hpvHLHF3lI0wdTbMLifQZUsyNo4MZwDj6VUfPDjSAB/YI+Es+Y/5d4zAq/48VeJXDlMvSYuZLElxjcliGgl2XDTKBo8ZGJ7qKdf7r45de471naI7ZW67anMMVZHnuwoIQtM5+OGsL4=
Reply-To: pantelis@embeddedalley.com
Organization: EASI
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Au1x00 8250 uart support (Updated - take #4).
Date: Sun, 6 Nov 2005 11:02:21 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, cw@f00f.org,
       Pete Popov <ppopov@embeddedalley.com>,
       Matt Porter <mporter@embeddedalley.com>, ralf@linux-mips.org
References: <200509192340.10450.pantelis@embeddedalley.com> <200509222211.22674.pantelis@embeddedalley.com> <20051106084424.GC25134@flint.arm.linux.org.uk>
In-Reply-To: <20051106084424.GC25134@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511061102.22033.pantelis@embeddedalley.com>
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 November 2005 10:44, Russell King wrote:
> On Thu, Sep 22, 2005 at 10:11:21PM +0300, Pantelis Antoniou wrote:
> > Once more, with the MEM32 chunks out.
> > 
> > Regards
> > 
> > Pantelis
> 
> Do you have a description and sign-off for this patch?
> 
> 

---

Support Au1x00 8250 UARTs using the generic 8250 driver.
The offsets of the registers are in a different place, and
some parts cannot handle a full set of modem control signals.

---

Signed-off-by: Pantelis Antoniou <pantelis@embeddedalley.ocm>

----
