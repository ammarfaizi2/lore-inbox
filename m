Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313120AbSDYNG5>; Thu, 25 Apr 2002 09:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313122AbSDYNG4>; Thu, 25 Apr 2002 09:06:56 -0400
Received: from [203.200.51.170] ([203.200.51.170]:39921 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S313120AbSDYNGz>; Thu, 25 Apr 2002 09:06:55 -0400
Message-Id: <200204251310.g3PD9dI00738@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII
From: rpm <rajendra.mishra@timesys.com>
Reply-To: rajendra.mishra@timesys.com
Organization: Timesys
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, Nikita@Namesys.COM,
        Andrey Ulanov <drey@rt.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: FPU, i386
Date: Thu, 25 Apr 2002 18:39:38 +0530
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200204171440.JAA76065@tomcat.admin.navo.hpc.mil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 April 2002 08:10 pm, Jesse Pollard wrote:
> ---------  Received message begins Here  ---------
>

> if (int(1/h * 100) == int(5.0 * 100))
>
> will give a "proper" result within two decimal places. This is still
> limited since there are irrational numbers within that range that COULD
> still come out with a wrong answer, but is much less likely to occur.
>
> Exact match of floating point is not possible - 1/h is eleveated to a
> float.
>
> If your 1/h was actually num/h, and num computed by summing .01 100 times
> I suspect the result would also be "wrong".
>

why is exact match of floating point not possible ?
what i understand is if you  do a  " x/y " (where x and y are two integers ) 
division in hardware then you should always get the same value , then why 
can't we compare floating point "==" operation ?
   I understand that in case of inrrational number it will not give a exact 
value ......but division like 1/.2 is not irrational ! and it should always 
come to 5 !
 
rpm
