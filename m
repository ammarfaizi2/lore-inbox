Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030570AbVKDBvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030570AbVKDBvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbVKDBvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 20:51:23 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:27710 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030570AbVKDBvX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 20:51:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nK4PN/00vsPEX+kAAqRDLB1HuvKhHz38bk8dCpEStGX39XBIXnb1QNI6uxEFf6oHdjRumJQbVDXzshL9ivnjkCVkAuivyx6AEXpeRKWoFAqvnZ2LypELLAd3pJ527Y3mwk9NgGFjF7Rdav2Tb1AKtL4/1fSjogWAn+J2TY/djF0=
Message-ID: <4807377b0511031751r22301fd8q4397dd504a32fa39@mail.gmail.com>
Date: Thu, 3 Nov 2005 17:51:22 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: linas@austin.ibm.com
Subject: Re: [PATCH 29/42]: ethernet: add PCI error recovery to e100 dev driver
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <4807377b0511031734gfc23c5fm31050bc8ee47c0c5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051103235918.GA25616@mail.gnucash.org>
	 <20051104005353.GA27074@mail.gnucash.org>
	 <4807377b0511031734gfc23c5fm31050bc8ee47c0c5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:
> I think these patches will be great, on the pseries, but
> is there not a compile option that should compile out all this code, i.e.
> #ifdef PCI_ERROR_RECOVERY
>
> if the arch doesn't support it?

Uh, i just saw patch 32, never mind.
