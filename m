Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272667AbRHaLUM>; Fri, 31 Aug 2001 07:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272668AbRHaLUC>; Fri, 31 Aug 2001 07:20:02 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:22798 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S272667AbRHaLTr>; Fri, 31 Aug 2001 07:19:47 -0400
Message-ID: <3B8F7304.33BAE89A@loewe-komp.de>
Date: Fri, 31 Aug 2001 13:20:36 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: umesh jaiswal <umesh_j123@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: how to know to which file in kernel the  patch can be applied?
In-Reply-To: <F78EdcWCJ2geAvaFI7J00002fb5@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

umesh jaiswal wrote:
> 
> Dear sir ...
>    I have applied  a linux-2_2_16_diff.htm patch which I have downloaded
> from kgdb site for remote kernel debugging by giving the command
>             cd /usr/src/linun2.2.16
>            $[linux] patch p0 < linux-2_2_16_diff.htm
> 
> But after appling the above  patch  command the console giving the massage :
> type the file name you want to patch.
>   I don't know sir which file I have to patch for remote kernel debugging
> support on my development machine .pls help me out.
> 

Most of the patches assume that your current working directory is
/usr/src
If you are in /usr/src/linux*  try "patch -p1 <patch"
You can browse the patch with less and see at the "diff" line what
the expected hierachy looks like
