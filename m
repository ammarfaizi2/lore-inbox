Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135318AbQLOAo6>; Thu, 14 Dec 2000 19:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135386AbQLOAok>; Thu, 14 Dec 2000 19:44:40 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:9992 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S135428AbQLOAo1>; Thu, 14 Dec 2000 19:44:27 -0500
From: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Linus's include file strategy redux
Date: 15 Dec 2000 00:14:04 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <91bnoc$vij$2@enterprise.cistron.net>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com>
X-Trace: enterprise.cistron.net 976839244 32339 195.64.65.67 (15 Dec 2000 00:14:04 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com>,
LA Walsh <law@sgi.com> wrote:
>Which works because in a normal compile environment they have /usr/include
>in their include path and /usr/include/linux points to the directory
>under /usr/src/linux/include.

No, that a redhat-ism.

Sane distributions simply include a known good copy of
/usr/src/linux/include/{asm,linux} verbatim in their libc6-dev package.

Debian has done that for a long, long time.

Several core glibc developers use Debian, are even Debian developers...

Mike.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
