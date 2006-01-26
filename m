Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWAZHOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWAZHOa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 02:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWAZHO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 02:14:29 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:12269 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750796AbWAZHO3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 02:14:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NQgapaInLmiSNxYkcHQqqm8cp/KGabNbBanQ09/kl1vxS9kezHBO23lhApgmOXbQsUNCOxigluOU9es2En/bSz5/nqO82ySn2cwrsbDJsCIzKhJtf10hj0f4j2o7MGFzWG+s90jtU6SVJ9/YowJXk30QNT7M3khHPUYBau/nEAc=
Message-ID: <84144f020601252303x7e2a75c6rdfe789d3477d9317@mail.gmail.com>
Date: Thu, 26 Jan 2006 09:03:55 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.16-rc1-mm3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43D7E83D.7040603@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124232406.50abccd1.akpm@osdl.org>
	 <43D785E1.4020708@shadowen.org>
	 <84144f020601250644h6ca4e407q2e15aa53b50ef509@mail.gmail.com>
	 <43D7AB49.2010709@shadowen.org> <1138212981.8595.6.camel@localhost>
	 <43D7E83D.7040603@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Pekka Enberg wrote:
> > Does vanilla 2.6.16-rc1 work for you? The oops definitely makes me think
> > it's slab related but the other patches don't seem likely suspects.

On 1/25/06, Andy Whitcroft <apw@shadowen.org> wrote:
> None of the other patches you suggested seem to be it either :/.  Yes
> 2.6.16-rc1 was ok on the boxs in question.

Then I dont see how it could be slab related. At this point, the only
suggestion I have is bisecting akpm-style:

http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

Thanks!

                                     Pekka
