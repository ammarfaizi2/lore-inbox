Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291665AbSBHRdL>; Fri, 8 Feb 2002 12:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291675AbSBHRdC>; Fri, 8 Feb 2002 12:33:02 -0500
Received: from inetgw.eproduction.ch ([212.249.19.98]:63242 "EHLO
	inetgw.eproduction.ch") by vger.kernel.org with ESMTP
	id <S291666AbSBHRcm>; Fri, 8 Feb 2002 12:32:42 -0500
Message-ID: <3C640C90.E71E3F70@eproduction.ch>
Date: Fri, 08 Feb 2002 18:36:16 +0100
From: "Peter H. =?iso-8859-1?Q?R=FCegg?=" <pruegg@eproduction.ch>
Organization: eProduction AG
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.setup
To: linux-kernel@vger.kernel.org
Subject: Problem with mke2fs on huge RAID-partition
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I just build a nice little fileserver consisting of 2 40GB-HD's with
some RAID-1 partitions and 6 80 GB-HD's on 3 Promise Ultra 100 TX-Adapters
as a RAID-5 partition.

All RAID is done in software, using (at the moment) a Standard RedHat 7.2
Kernel 2.4.7.

My problem is: If I start mke2fs [1] on the device, it writes everything
down until "Writing Superblocks...". The system then completly hangs.
And yes, I did wait long enough (well, at least I think 15 hours should
be enough ;-)

Is there a limitation in the maximum size of a partition (well, 400 GB is
not that small...), may it be a (known) problem of mke2fs or the particular
Kernel-Version, or does anyone have any suggestions where else to seek?

Thanks in advance

 
Peter H. Ruegg
Systems-/Networkadministrator eProduction AG

--8<-------------------------------------------------------------------------
main(){char*s="O_>>^PQAHBbPQAHBbPOOH^^PAAHBJPAAHBbPA_H>BB";int i,j,k=1,l,m,n;
for(j=0;j<7;j++)for(l=0;m=l-6+j,i=m/6,n=j*6+i,k=1<<m%6,l<41-j;l++)
putchar(l<6-j?' ':l==40-j?'\n':k&&s[n]&k?'*':' ');}
