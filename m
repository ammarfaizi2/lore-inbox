Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSE3LBj>; Thu, 30 May 2002 07:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSE3LBi>; Thu, 30 May 2002 07:01:38 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:17393 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316578AbSE3LBh>; Thu, 30 May 2002 07:01:37 -0400
Subject: Re: File corrupting bug in kernel 2.2.19 as well as 2.2.20 ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver <oliver@wilmskamp.dyndns.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205301233.59618.oliver@wilmskamp.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 May 2002 13:05:21 +0100
Message-Id: <1022760321.9255.347.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-30 at 11:33, Oliver wrote:
> files seemed to be corrupted (e.g. /etc/apache/httpd.conf, 
> /var/lib/dpkg/available and others). those files had some parts replaced 
> with ...^@^@^@^@^@... stuff, which are zero-bytes (0x00) (again: there 
> were only some parts REPLACED in these files, the filelength had NOT 
> changed). thats not too funny for a running server as you can imagine ;) 

16 or 32 byte long chunks ?

.

