Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281555AbRKUJoN>; Wed, 21 Nov 2001 04:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281506AbRKUJoE>; Wed, 21 Nov 2001 04:44:04 -0500
Received: from mout02.kundenserver.de ([195.20.224.133]:58900 "EHLO
	mout02.kundenserver.de") by vger.kernel.org with ESMTP
	id <S281441AbRKUJnw> convert rfc822-to-8bit; Wed, 21 Nov 2001 04:43:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Eric M <ground12@jippii.fi>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-pre1:  "bogus" message with reiserfs root and other weirdness
Date: Wed, 21 Nov 2001 10:43:24 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <6893478.1006329318464.JavaMail.ground12@jippii.fi>
In-Reply-To: <6893478.1006329318464.JavaMail.ground12@jippii.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166Tv4-0001Y9-00@mrvdom00.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FAT: bogus logical sector size 0

It is not a problem at all.

It happens if you compile fat in the Kernel and not as module. In this case 
the fat-driver seems to check every partition for a fat-filesystem. When it 
fails it gives you this message. 

So you can 
1. ignore these messages or
2. compile fat as a module.

greetings

Christian
