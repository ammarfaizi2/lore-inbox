Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262110AbREQRtO>; Thu, 17 May 2001 13:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262106AbREQRtF>; Thu, 17 May 2001 13:49:05 -0400
Received: from patan.Sun.COM ([192.18.98.43]:7886 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S262103AbREQRsr>;
	Thu, 17 May 2001 13:48:47 -0400
Message-ID: <3B040C80.C2A7BC6@sun.com>
Date: Thu, 17 May 2001 10:38:08 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.4 failure to compile
In-Reply-To: <Pine.LNX.3.95.1010517132052.14991A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> Hello;
> 
> I downloaded linux-2.4.4. The basic kernel compiles but the aic7xxx
> SCSI module that I require on some machines, doesn't.

The aic7xxx assembler requiring libdb1 is a bungle.  Getting the headers
for that right on various distros is not easy.  Add to that it requires
YACC, when most people have bison (yes, a shell script is easy to make, but
not always an option). 


-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
