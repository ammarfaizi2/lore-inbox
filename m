Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315844AbSEJIgg>; Fri, 10 May 2002 04:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315845AbSEJIgg>; Fri, 10 May 2002 04:36:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:20734 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315844AbSEJIge>;
	Fri, 10 May 2002 04:36:34 -0400
Message-ID: <3CDB86C3.8050706@gmx.de>
Date: Fri, 10 May 2002 10:37:23 +0200
From: Pierre Bernhardt <mirrorgate@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: de-DE
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Subject: Re: 2.5.15 hangs at partition check
In-Reply-To: <3CDB8092.8090007@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Pierre Rousselet wrote:

> PIII / Abit BE6 HPT366, devfs.
> 
> 2.5.15 doesn't boot, the last lines are :
> 
> hde: 20005650 sectors w/512KiB Cache, CHS=19846/16/63, UDMA(66)
> hdg: 6250608 sectors w/478KiB Cache, CHS=11024/9/63, UDMA(33)
> Partition check:
>  /dev/ide/host2/bus0/target0/lun0:
> 
> 2.5.14 works, it gives :
> hde: 20005650 sectors w/512KiB Cache, CHS=19846/16/63, UDMA(66)
> hdg: 6250608 sectors w/478KiB Cache, CHS=11024/9/63, UDMA(33)
> Partition check:
>  /dev/ide/host2/bus0/target0/lun0: [PTBL] [1245/255/63] p1 p2 p3 p4
>  /dev/ide/host3/bus0/target0/lun0: p1


Hi,

i have the same problem on Abit BP6 with HPT366 and Kernel 2.4.18 based
on SuSE 8.0 SMP-Kernel.

Partition check:
  hda: hda1 hda2 hda3 hda4
  hdc: hdc1 hdc2 hdc3 hdc4
  hde:

Failsave-Kernel of this Distribution works fine.

Here some Infos:

starflake:/sbin # uname -a
Linux starflake 2.4.18-64GB-SMP #1 SMP Wed Mar 27 13:58:12 UTC 2002 i686 
unknown
starflake:/sbin # cat /etc/SuSE-release
SuSE Linux 8.0 (i386)
VERSION = 8.0

Pierre



