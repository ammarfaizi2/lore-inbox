Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbRFTPeO>; Wed, 20 Jun 2001 11:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbRFTPeF>; Wed, 20 Jun 2001 11:34:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51875 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264907AbRFTPd5>;
	Wed, 20 Jun 2001 11:33:57 -0400
Date: Wed, 20 Jun 2001 11:33:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jes Sorensen <jes@sunsite.dk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bert hubert <ahu@ds9a.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <d37ky7ch0w.fsf@lxplus015.cern.ch>
Message-ID: <Pine.GSO.4.21.0106201127350.24658-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 20 Jun 2001, Jes Sorensen wrote:

> Not to mention how complex it is to get locking right in an efficient
> manner. Programming threads is not that much different from kernel SMP
> programming, except that in userland you get a core dump and retry, in
> the kernel you get an OOPS and an fsck and retry.

Arrgh. As long as we have that "SMP makes locking harder" myth floating
around we _will_ get problems. Kernel UP programming is not different
from SMP one. It is multithreaded. And amount of genuine SMP bugs is
very small compared to ones that had been there on UP since way back.
And yes, programming threads is the same thing. No arguments here.

