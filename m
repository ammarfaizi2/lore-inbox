Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312691AbSDFSdJ>; Sat, 6 Apr 2002 13:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312712AbSDFSdI>; Sat, 6 Apr 2002 13:33:08 -0500
Received: from moutng0.kundenserver.de ([212.227.126.170]:15827 "EHLO
	moutng0.schlund.de") by vger.kernel.org with ESMTP
	id <S312691AbSDFSdG>; Sat, 6 Apr 2002 13:33:06 -0500
Date: Sat, 6 Apr 2002 20:32:40 +0200
From: Martin Hermanowski <martin@mh57.net>
To: Ookhoi <ookhoi@humilis.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scsi0:0:10:0: Attempting to queue an ABORT message, scsi0:0:10:0: Command not found, aic7xxx_abort returns 0x2002
Message-ID: <20020406183240.GB25984@mh57.net>
Mail-Followup-To: Ookhoi <ookhoi@humilis.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020406142544.F19096@humilis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-PGP-Fingerprint: 3A8B 6A9A 3353 8CE7 9C95  31C8 0277 FA58 1FEA 0DF4
X-PGP-Key-ID: 1FEA0DF4
X-PGP-Key-At: http://empyreum.de/pgp-keys/MH.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you using an smp kernel? I have similar messages at boot time, if I
use a smp enabled kernel (IBM Netfinity 5000, Adaptec 2940 or 29160).

On Sat, Apr 06, 2002 at 02:25:44PM +0200, Ookhoi wrote:
> Hi people,
> 
> dmesg gives a lot of lines like this:
> 
> scsi0:0:10:0: Attempting to queue an ABORT message
> scsi0:0:10:0: Command not found
> aic7xxx_abort returns 0x2002
> scsi0:0:10:0: Attempting to queue an ABORT message
> scsi0:0:10:0: Command not found
> aic7xxx_abort returns 0x2002
> scsi0:0:10:0: Attempting to queue an ABORT message
> scsi0:0:10:0: Command not found
> aic7xxx_abort returns 0x2002
> 
> We think it is a hardware problem, but I thought it is a good thing to
> ask here for suggestions. I searched the archives and the web, but could
> only find similar messages dated last year. 
> 
> I'm happy to provide more info, but hope all below is enough. Thanks in 
> advance for suggestions or hints!
> 
>         Ookhoi
> 
> 
> kernel 2.4.19-pre2-ac4
> asus a7m266-d (amd 760mxp)
> 00:08.0 SCSI storage controller: Adaptec 7892A (rev 02)
[...]

-- 
PGP/GPG encrypted mail preferred, see header
,-- 
| Nur tote Fische schwimmen mit dem Strom
`--
