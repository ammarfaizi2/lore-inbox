Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263405AbRF0KzJ>; Wed, 27 Jun 2001 06:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264072AbRF0Ky6>; Wed, 27 Jun 2001 06:54:58 -0400
Received: from AMontpellier-201-1-2-148.abo.wanadoo.fr ([193.253.215.148]:25868
	"EHLO awak") by vger.kernel.org with ESMTP id <S263405AbRF0Kys>;
	Wed, 27 Jun 2001 06:54:48 -0400
Subject: Re: VM Requirement Document - v0.0
From: Xavier Bestel <xavier.bestel@free.fr>
To: Dan Maas <dmaas@dcine.com>
Cc: Stefan Hoffmeister <lkml.2001@econos.de>, linux-kernel@vger.kernel.org
In-Reply-To: <003f01c0fea2$39a64950$0701a8c0@morph>
In-Reply-To: <fa.oqkojpv.3hosb7@ifi.uio.no> <fa.jpsks3v.1o2gag4@ifi.uio.no> 
	<003f01c0fea2$39a64950$0701a8c0@morph>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 27 Jun 2001 12:50:17 +0200
Message-Id: <993639018.5342.25.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jun 2001 20:43:33 -0400, Dan Maas wrote:
> > Windows NT/2000 has flags that can be for each CreateFile operation
> > ("open" in Unix terms), for instance
> >
> >   FILE_ATTRIBUTE_TEMPORARY
> >   FILE_FLAG_WRITE_THROUGH
> >   FILE_FLAG_NO_BUFFERING
> >   FILE_FLAG_RANDOM_ACCESS
> >   FILE_FLAG_SEQUENTIAL_SCAN
> >
> 

We do (nearly) already have O_DIRECT which won't touch cache (alas I
don't think I will read-ahead more)

Xav

