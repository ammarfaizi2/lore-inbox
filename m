Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWEEFqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWEEFqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 01:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWEEFqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 01:46:25 -0400
Received: from wx-out-0102.google.com ([66.249.82.205]:55967 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932467AbWEEFqZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 01:46:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O3ha9KjE7O0B51ptefAFx1B2atKMena1Ny9RCZxrLXZg9l2hBGgD4/8Cv4zjBjvUulWme77v5WTOU/5+AJRn+IFR3xmWavrhRpybDy1/epnw9o6sG6eUn0tgCyfRKwOlqclyeh35cGnK2C976YbbTSZolrYLHVYDBqCpQRbFZLk=
Message-ID: <2151339d0605042246n1e40a496l8af646218edc781e@mail.gmail.com>
Date: Thu, 4 May 2006 22:46:24 -0700
From: "Nathan Becker" <nathanbecker@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200605041922.52243.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com>
	 <2151339d0605032152g64ec77bfhe90dc08180463c31@mail.gmail.com>
	 <20060504052751.GA23054@kroah.com>
	 <200605041922.52243.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, GART_IOMMU is already turned on.  Do you want me to send more
detailed debugging messages?

> Presumably you're running with the GART IOMMU?  If not, then turn
> that on.  Maybe even turn on IOMMU_DEBUG.
