Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314769AbSEXTaM>; Fri, 24 May 2002 15:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314783AbSEXTaL>; Fri, 24 May 2002 15:30:11 -0400
Received: from moutng1.kundenserver.de ([212.227.126.171]:51444 "EHLO
	moutng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S314769AbSEXTaK> convert rfc822-to-8bit; Fri, 24 May 2002 15:30:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-15?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Matt Simonsen <matt_lists@careercast.com>, linux-kernel@vger.kernel.org
Subject: Re: mount --bind for fstab
Date: Fri, 24 May 2002 21:29:57 +0200
User-Agent: KMail/1.4.1
In-Reply-To: <1022267152.1020.20.camel@mattswork>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205242129.57664.linux-kernel@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Simonsen wrote:
> I found it once a week ago, but I can't find the syntax to use in fstab
> to mount drives in the "mount --bind olddir newdir" syntax.

The line 

/dev/shm /tmp none bind

might be what you want.


greetings

Christian




