Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264125AbRFTQmE>; Wed, 20 Jun 2001 12:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFTQlz>; Wed, 20 Jun 2001 12:41:55 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:44815 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S264125AbRFTQll>;
	Wed, 20 Jun 2001 12:41:41 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bert hubert <ahu@ds9a.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <Pine.GSO.4.21.0106201127350.24658-100000@weyl.math.psu.edu>
From: Jes Sorensen <jes@sunsite.dk>
Date: 20 Jun 2001 18:40:53 +0200
In-Reply-To: Alexander Viro's message of "Wed, 20 Jun 2001 11:33:55 -0400 (EDT)"
Message-ID: <d31yofcdey.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Al" == Alexander Viro <viro@math.psu.edu> writes:

Al> On 20 Jun 2001, Jes Sorensen wrote:

>> Not to mention how complex it is to get locking right in an
>> efficient manner. Programming threads is not that much different
>> from kernel SMP programming, except that in userland you get a core
>> dump and retry, in the kernel you get an OOPS and an fsck and
>> retry.

Al> Arrgh. As long as we have that "SMP makes locking harder" myth
Al> floating around we _will_ get problems. Kernel UP programming is
Al> not different from SMP one. It is multithreaded. And amount of
Al> genuine SMP bugs is very small compared to ones that had been
Al> there on UP since way back.  And yes, programming threads is the
Al> same thing. No arguments here.

Call it SMP or kernel threading, I don't really care, it's the same
thing. My point is that in the kernel you must take threading/SMP into
account when coding and yes it's not trivial to do it efficiently
(though often fairly easy to do it inefficiently) and the same applies
to userland threads. Userland threads are just not some chest of gold
that just opens up a free path to paradise as most CS teachers seems
to promote it as being.

Jes
