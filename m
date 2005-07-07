Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVGGJHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVGGJHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 05:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVGGJHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 05:07:15 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:30327 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261166AbVGGJHN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 05:07:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Iwg3ROLSVqIMxLLMIp5SGqGqAJU3ijgPrEzimW0VeR7j3GZwXsyEgDXY+t9CUU2nqGZLTBukKlkpbP0xl6i74Qgk8SScbfNzkHkHOFhcElr0Nn+UylylrMgJOtMpA73vWkppriZLa49+kw2bYaTcTPCBkX5Qnmaq/CRqwF/B4CE=
Message-ID: <84144f02050707020765f81c38@mail.gmail.com>
Date: Thu, 7 Jul 2005 12:07:11 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Lenz Grimmer <lenz@grimmer.com>
Subject: Re: Head parking (was: IBM HDAPS things are looking up)
Cc: Jens Axboe <axboe@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <42CCEAA7.1010807@grimmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42C8D06C.2020608@grimmer.com> <20050704063741.GC1444@suse.de>
	 <1120461401.3174.10.camel@laptopd505.fenrus.org>
	 <20050704072231.GG1444@suse.de>
	 <1120462037.3174.25.camel@laptopd505.fenrus.org>
	 <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com>
	 <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de>
	 <42CCEAA7.1010807@grimmer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> > ATA7 defines a park maneuvre, I don't know how well supported it is
> > yet though. You can test with this little app, if it says 'head
> > parked' it works. If not, it has just idled the drive.

On 7/7/05, Lenz Grimmer <lenz@grimmer.com> wrote:
> Great! Thanks for digging this up - it works on my T42, using a Fujitsu
> MHT2080AH drive:

Works on my T42p which uses a Hitachi HTS726060M9AT00 drive. I don't
hear any sound, though.

                              Pekka
