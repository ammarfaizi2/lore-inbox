Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVKVXqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVKVXqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVKVXqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:46:54 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:15198 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030258AbVKVXqx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:46:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LTUeLV9FIdsmdI8mN1JHwqMHJfDeEG5RKlnVVJ1QtXo1rx9sSnImlZZXQIe8vpSFHiKRVIL/u8OMIZBSdKtCmzHLj0kupV//b72IJaAEUDrzySC/jFLJLEp4rcBuP3c2AeAnznAMi81vHuCZUvT3itT5opyQLbp9qJGP8j6yz3M=
Message-ID: <4807377b0511221546h7a16c0a9p793e441197b23118@mail.gmail.com>
Date: Tue, 22 Nov 2005 15:46:52 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
Subject: Re: e1000 82571 Packet Splitting
Cc: linux-kernel@vger.kernel.org,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>
In-Reply-To: <43838614.9080807@soleranetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43838614.9080807@soleranetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this should be on netdev.

On 11/22/05, Jeff V. Merkey <jmerkey@soleranetworks.com> wrote:
>
> I have noted that the e1000 driver is now supporting DMA splitting of
> the packet header and payload into separate pages.  I also noticed
> that none of the config options enable it.  Is anyone using this feature
> at present and has it even been tested on Linux?

The 6.2.15 driver off http://prdownloads.sf.net/e1000 will enable it
by default.  We've gone through our release approval, which includes
quite a bit of testing.
If the patches posted recently don't include that support, I missed
something :-)

This is only on the 82571 and greater hardware that packet split is
supported, BTW.
