Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVEMTZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVEMTZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVEMTW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:22:56 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:25993 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262491AbVEMTQM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:16:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mOY5x4l95Jkzh9r30p5XZNQ3OS56MplyKmm/K0vNcGyHy+1Wn7nujA6Mbcm7YuRMgUu8kZCC970WtHt7zHVH9oKPVNWuSjgOeaAyF31gx+MLppYjyPvLKRbu7mCXkhU8K0ctrlDrHM6xU+VIczHy3JjQykFfVPHC2W/QWvFnb9Y=
Date: Fri, 13 May 2005 21:16:09 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Andi Kleen <ak@muc.de>
Cc: gmicsko@szintezis.hu, linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-Id: <20050513211609.75216bf8.diegocg@gmail.com>
In-Reply-To: <m164xnatpt.fsf@muc.de>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	<m164xnatpt.fsf@muc.de>
X-Mailer: Sylpheed version 1.9.9+svn (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 13 May 2005 20:03:58 +0200,
Andi Kleen <ak@muc.de> escribió:


> This is not a kernel problem, but a user space problem. The fix 
> is to change the user space crypto code to need the same number of cache line
> accesses on all keys. 


However they've patched the FreeBSD kernel to "workaround?" it:
ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09/htt5.patch

