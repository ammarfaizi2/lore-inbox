Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137182AbREKRjf>; Fri, 11 May 2001 13:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137189AbREKRj0>; Fri, 11 May 2001 13:39:26 -0400
Received: from [213.77.236.124] ([213.77.236.124]:3712 "HELO
	marek.almaran.home") by vger.kernel.org with SMTP
	id <S137182AbREKRjJ>; Fri, 11 May 2001 13:39:09 -0400
Date: Fri, 11 May 2001 19:36:05 +0200
From: =?iso-8859-2?Q?Marek_P=EAtlicki?= <marpet@buy.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac7
Message-ID: <20010511193605.A1160@marek.almaran.home>
In-Reply-To: <E14yDLv-0000v7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14yDLv-0000v7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 11, 2001 at 03:59:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May, 2001-05-11 at 15:59:16, Alan Cox wrote:
> 
>  	     ftp://ftp.linux.org.uk/pub/linux/alan/2.4-ac/
> 
> 		 Intermediate diffs are available from
> 			http://www.bzimage.org
> 
> **
> ** Please note change of ftp site. ftp.kernel.org switched to using ECN and
> ** it seems NTL's cablemodem folks have problem firewalls between their
> ** Inktomi cache and the world. The -ac patches and future 2.2.20pre will be 
> ** distributed from ftp.linux.org.uk until further notice.
> **
> 
> 2.4.4-ac7

is the EXTRAVERSION set properly in Makefile? I use the http://www.bzimage.org
intermediate diff (chosen ~40K to ~2M) from ac6 nd I still have
2.4.4-ac6 login prompt (and Makefile says: EXTRAVERSION = -ac6).

The other thing I noticed is:

 depmod
depmod: *** Unresolved symbols in /lib/modules/2.4.4-ac6/kernel/fs/nfs/nfs.o

 modprobe nfs
/lib/modules/2.4.4-ac6/kernel/fs/nfs/nfs.o: unresolved symbol filemap_fdatawait_Rd4250148
/lib/modules/2.4.4-ac6/kernel/fs/nfs/nfs.o: unresolved symbol filemap_fdatasync_Rf18ce7a1
/lib/modules/2.4.4-ac6/kernel/fs/nfs/nfs.o: insmod /lib/modules/2.4.4-ac6/kernel/fs/nfs/nfs.o failed
/lib/modules/2.4.4-ac6/kernel/fs/nfs/nfs.o: insmod nfs failed

I don't use it, must've checked it in by mistake. Nevertheless I report
:-)


regards and bye

-- 
Marek Pêtlicki <marpet@buy.pl>

