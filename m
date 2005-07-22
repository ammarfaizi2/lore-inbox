Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVGVH5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVGVH5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 03:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVGVH5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 03:57:08 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:10014 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262058AbVGVH5H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 03:57:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m40p2GdpPd1ZlxFOgyLl6cNAxjv2g/DYiRb3jdeiuMZYOjcPV4Ofboc+SzRjjn6Qy82R9bmMMQdb6EIdXrj4gz7IV0MVmS+7J1iooenzLoa3uJ2kDUrQesU/0NISoDwMhRBo+iDec2BOKQbMkCpNdF/fabU3iV6/p9ONPSUWM8k=
Message-ID: <7f800d9f0507220016d8c26e6@mail.gmail.com>
Date: Fri, 22 Jul 2005 00:16:38 -0700
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: bert hubert <bert.hubert@netherlabs.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: fastboot, diskstat
In-Reply-To: <20050722034135.GA21201@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050722034135.GA21201@outpost.ds9a.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/7/21, bert hubert <bert.hubert@netherlabs.nl>:
> I'm currently at OLS and presented http://ds9a.nl/diskstat yesterday, which
> also references your ancient 'fboot' program.

Bert,

ever so slightly off topic, but you mentioned parallelized startup in
your slides...

So checkout initng for your tests. It's a highly parallelized init
system which seriously speeds up boot. It also keeps the disks much
busier during boot and might help your testing.

Initng:
http://initng.thinktux.net

Cheers,
   Andre
