Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288925AbSAIGpx>; Wed, 9 Jan 2002 01:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288919AbSAIGpn>; Wed, 9 Jan 2002 01:45:43 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:51943 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S288926AbSAIGp0>;
	Wed, 9 Jan 2002 01:45:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Brian <hiryuu@envisiongames.net>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Date: Tue, 8 Jan 2002 22:45:23 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0201072122290.14092-100000@localhost.localdomain> <20020108193904.A1068@w-mikek2.beaverton.ibm.com> <0GPN00CMLRC7U8@mtaout45-01.icomcast.net>
In-Reply-To: <0GPN00CMLRC7U8@mtaout45-01.icomcast.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16OCUF-0000mG-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 8, 2002 22:29, Brian wrote:
> Can this be correct?
>
> Intuitively, I would expect several CPUs hammering away at the compile to
> finish faster than one.  Given these numbers, I would have to conclude
> that is not just wrong, but absolutely wrong.  Compile time increases
> linearly with the number of jobs, regardless of the number of CPUs.

In the charts in the original message, he's not increasing the number of 
jobs, but the number of concurrent 'make -j8's. Two makes should really 
finish in half the time one make does. I don't see any problem with the 
results.

-Ryan
