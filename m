Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137214AbREKTFS>; Fri, 11 May 2001 15:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143368AbREKTFI>; Fri, 11 May 2001 15:05:08 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:36621 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S137216AbREKTEk>; Fri, 11 May 2001 15:04:40 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marpet@buy.pl (Marek P=?iso-8859-2?Q?=EAtlicki?=),
        linux-kernel@vger.kernel.org
Message-ID: <86256A49.0068AF0B.00@smtpnotes.altec.com>
Date: Fri, 11 May 2001 14:03:50 -0500
Subject: Re: Linux 2.4.4-ac7
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=2nujhCGTPeUzauQvLdXiU0I879Ys5p29NhmFVZWIUUYZWbHeltp4LEpv"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=2nujhCGTPeUzauQvLdXiU0I879Ys5p29NhmFVZWIUUYZWbHeltp4LEpv
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



My modules/filemap.ver has the same in it as yours.

Wayne




Alan Cox <alan@lxorguk.ukuu.org.uk> on 05/11/2001 01:52:18 PM

To:   Wayne Brown/Corporate/Altec@Altec
cc:   alan@lxorguk.ukuu.org.uk (Alan Cox), marpet@buy.pl (Marek P
--0__=2nujhCGTPeUzauQvLdXiU0I879Ys5p29NhmFVZWIUUYZWbHeltp4LEpv
Content-type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-transfer-encoding: quoted-printable


=EAtlicki),
      linux-kernel@vger.kernel.org

Subject:  Re: Linux 2.4.4-ac7


=

--0__=2nujhCGTPeUzauQvLdXiU0I879Ys5p29NhmFVZWIUUYZWbHeltp4LEpv
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline


> I always make mrproper after applying your patches, and I still got exactly
the
> same problem with nfs that Marek found.  There were no errors or warnings
during
> the compile of the objects in the fs/nfs directory or the linking of nfs.o.
>
Curious : my build has

#define __ver_filemap_fdatasync    f18ce7a1
#define filemap_fdatasync     _set_ver(filemap_fdatasync)
#define __ver_filemap_fdatawait    d4250148
#define filemap_fdatawait     _set_ver(filemap_fdatawait)

in modules/filemap.ver

I'll have a look




--0__=2nujhCGTPeUzauQvLdXiU0I879Ys5p29NhmFVZWIUUYZWbHeltp4LEpv--

