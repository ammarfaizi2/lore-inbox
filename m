Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277818AbRJKCWQ>; Wed, 10 Oct 2001 22:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277811AbRJKCWF>; Wed, 10 Oct 2001 22:22:05 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:33297 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S277511AbRJKCWB>; Wed, 10 Oct 2001 22:22:01 -0400
Date: Thu, 11 Oct 2001 04:22:28 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <laughing@shared-source.org>
Subject: Re: Linux 2.4.10-ac11
Message-ID: <20011011042228.A10133@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <laughing@shared-source.org>
In-Reply-To: <20011011001617.A4636@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20011011001617.A4636@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Alan Cox wrote:

> *	Small fixes to various long standing bugs, various architecture and
> *	driver cleanups. The 2.4.10-ac tree now seems pretty solid.
> *
> 
> 2.4.10-ac11
> o	Further VM tuning				(Rik van Riel)

Short version: Kicks ass!

Long version: the sluggishness that 2.4.9, 2.4.10 and the previous -ac
versions suffered from (not sure if 2.4.7 was also sluggish) seems to be
gone, the machine is much quieter now and does not look like paralysed
for seconds every now and then. Stress tests need to be done, but a make
-j on various DJB tools which would start up only slowly now quickly
zoom through.


However, one thing strikes me on boot: ext3fs claims it's 0.9.6, while
the ext3 web site tells us about 0.9.10. What's going on with 2.4.x-ac
ext3fs? Should I be concerned?
