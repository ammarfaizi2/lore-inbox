Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273895AbRIXM7h>; Mon, 24 Sep 2001 08:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273896AbRIXM7Z>; Mon, 24 Sep 2001 08:59:25 -0400
Received: from mout03.kundenserver.de ([195.20.224.218]:40566 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S273895AbRIXM7V> convert rfc822-to-8bit; Mon, 24 Sep 2001 08:59:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed
Date: Mon, 24 Sep 2001 14:58:28 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20010924040208.A624@localhost.localdomain>
In-Reply-To: <20010924040208.A624@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15lVKr-0005cC-00@mrvdom00.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just installed 2.4.10, and...
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e

I saw the same message when running this c++ programm.

int main (int argc, char * argv[]) {
char * test;
while (1)
test=new char[1024];
}

My dmesg:

__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c01219e7
VM: killing process a.out

I have 512 MB RAM and no swap.
Actually the system slowed down a lot but worked fine again after the kill.
And a flood ping from another PC had no lost packages. 

