Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131538AbRCZOzb>; Mon, 26 Mar 2001 09:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131555AbRCZOzW>; Mon, 26 Mar 2001 09:55:22 -0500
Received: from smtp.alcove.fr ([212.155.209.139]:59920 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S131538AbRCZOzQ>;
	Mon, 26 Mar 2001 09:55:16 -0500
Date: Mon, 26 Mar 2001 16:54:25 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use semaphore for producer/consumer case...
Message-ID: <20010326165425.G15689@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <000d01c0b3c7$e232ae90$5517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <000d01c0b3c7$e232ae90$5517fea9@local>; from manfred@colorfullife.com on Fri, Mar 23, 2001 at 07:34:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 07:34:07PM +0100, Manfred Spraul wrote:
> >      consumer()
> 
> >             /* Let's wait for 10 items */
> >             atomic_set(&sem->count, -10);
> 
> That doesn't work, at least the i386 semaphore implementation doesn't
> support semaphore counts < 0.

Does that mean that kernel semaphore can not be used for something
else than mutual exclusion ?

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|------------- Ingénieur Informatique Libre --------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|----------- Alcôve, l'informatique est libre ------------|
