Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVLNOW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVLNOW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 09:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVLNOW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 09:22:57 -0500
Received: from [212.76.84.137] ([212.76.84.137]:1804 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932091AbVLNOW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 09:22:56 -0500
From: Al Boldi <a1426z@gawab.com>
To: Bernd Eckenfels <ecki@lina.inka.de>
Subject: Re: [RFC] ip / ifconfig redesign
Date: Wed, 14 Dec 2005 17:19:47 +0300
User-Agent: KMail/1.5
Cc: netdev@vger.kernel.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200512022253.19029.a1426z@gawab.com>
In-Reply-To: <200512022253.19029.a1426z@gawab.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200512141719.47755.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> Al Boldi wrote:
> > The current ip / ifconfig configuration is arcane and inflexible.  The
> > reason being, that they are based on design principles inherited from
> > the last century.
>
> Yes I agree, however note that some of the asumptions are backed up and
> required by RFCs. For example the binding of addresses to interfaces.  This
> is especially strongly required in the IPV6 world with all the scoping and
> renumbering RFCs.

Can you point me to those RFCs? Thanks!

> The things you want to change need to be changed in kernel space, btw.

True.

I mentioned ip / ifconfig not to imply that they are the culprit, but instead 
to expose the underlying kernel implementation.

This does not mean though, that ip / ifconfig cannot offer an emulated OSI 
compliant mode, which would be an impetus to change the underlying 
implementation.

Thanks!

--
Al

