Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbRGaBYY>; Mon, 30 Jul 2001 21:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269141AbRGaBYE>; Mon, 30 Jul 2001 21:24:04 -0400
Received: from rj.SGI.COM ([204.94.215.100]:40169 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S267474AbRGaBYD>;
	Mon, 30 Jul 2001 21:24:03 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac3 
In-Reply-To: Your message of "30 Jul 2001 10:32:11 MST."
             <9k45mr$mr1$1@cesium.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2001 11:23:57 +1000
Message-ID: <31713.996542637@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 30 Jul 2001 10:32:11 -0700, 
"H. Peter Anvin" <hpa@zytor.com> wrote:
>The way .version is currently created is in fact a huge problem... it
>means that if you do "make" as a user and then "make install" as root,
>it will have to rebuild several files and relink the kernel.  My
>opinion is that .version should probably be created as a side effect
>of linking vmlinux.

Funny about that.  It is exactly what I did in kbuild 2.5.  Now the
version number is only bumped if vmlinux needs to be relinked.

