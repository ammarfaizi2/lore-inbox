Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136148AbRDVOTK>; Sun, 22 Apr 2001 10:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136150AbRDVOTB>; Sun, 22 Apr 2001 10:19:01 -0400
Received: from t2.redhat.com ([199.183.24.243]:63729 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S136148AbRDVOSw>; Sun, 22 Apr 2001 10:18:52 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <041d01c0cb21$1f147e90$910201c0@zapper> 
In-Reply-To: <041d01c0cb21$1f147e90$910201c0@zapper>  <E14qHRp-0007Yc-00@the-village.bc.nu> <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com> <E14qXEU-0005xo-00@g212.hadiko.de> <9bqgvi$63q$1@penguin.transmeta.com> <3AE10741.FA4E40BD@gmx.de> <E14rGU8-0003zk-00@g212.hadiko.de> 
To: "Alon Ziv" <alonz@nolaviz.org>
Cc: linux-kernel@vger.kernel.org, dhowells@cambridge.redhat.com
Subject: Re: light weight user level semaphores 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Apr 2001 15:18:34 +0100
Message-ID: <27025.987949114@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alonz@nolaviz.org said:
>  [BTW, another solution is to truly support opaque "handles" to kernel
> objects; I believe David Howells is already working on something like
> this for Wine? The poll interface can be trivially extended to support
> waiting on those...]

ISTR it wasn't quite trivial to do it that way - it would require the 
addition of an extra argument to the fops->poll() method.

David?

--
dwmw2


