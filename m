Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266031AbRGQLQR>; Tue, 17 Jul 2001 07:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266047AbRGQLQH>; Tue, 17 Jul 2001 07:16:07 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:22352 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S266031AbRGQLPy> convert rfc822-to-8bit; Tue, 17 Jul 2001 07:15:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<christian@borntraeger.net>
To: David Balazic <david.balazic@uni-mb.si>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-ac5 gives wrong cache info for Duron in /proc/cpuinfo
Date: Tue, 17 Jul 2001 13:14:47 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B5413C9.2CE16AC9@uni-mb.si>
In-Reply-To: <3B5413C9.2CE16AC9@uni-mb.si>
MIME-Version: 1.0
Message-Id: <01071713144700.02683@Einstein.P-netz>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /proc/cpuinfo gives :
> cache size: 64 KB
>
> This is wrong :
>  - the Duron has 192 kilobytes of cache ( 64 L1 I, 64 L1 D , 64 L2 unified
> ) - what is KB ?

As far as I know older Durons have a bug. They report a wrong size for the 
cache.

>    - "kilo" is abbreviated to 'k' , not 'K'

Hmm, I think kilo is 1000 and K is 1024.
