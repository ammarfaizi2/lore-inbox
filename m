Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSGRHb1>; Thu, 18 Jul 2002 03:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSGRHb1>; Thu, 18 Jul 2002 03:31:27 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:63366 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313558AbSGRHb0>; Thu, 18 Jul 2002 03:31:26 -0400
Message-Id: <5.1.0.14.2.20020718083124.00af2600@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 18 Jul 2002 08:33:27 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: Remain Calm: Designated initializer patches for 2.5
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, viro@math.psu.edu,
       trond.myklebust@fys.uio.no, mnalis-umsdos@voyager.hr, al@alarsen.net,
       asun@cobaltnet.com, bfennema@falcon.csc.calpoly.edu, dave@trylinux.com,
       braam@clusterfs.com, chaffee@cs.berkeley.edu, dwmw2@infradead.org,
       eric@andante.org, hch@infradead.org, jaharkes@cs.cmu.edu,
       jakub@redhat.com, jffs-dev@axis.com, mikulas@artax.karlin.mff.cuni.cz,
       quinlan@transmeta.com, reiserfs-dev@namesys.com, mason@suse.com,
       rgooch@atnf.csiro.au, rmk@arm.linux.org.uk, shaggy@austin.ibm.com,
       tigran@veritas.com, urban@teststation.com, vandrove@vc.cvut.cz,
       vl@kki.org, zippel@linux-m68k.org, ahaas@neosoft.com
In-Reply-To: <3D3666A9.7050608@zytor.com>
References: <20020718032331.5A36644A8@lists.samba.org>
 <3D366103.8010403@zytor.com>
 <20020717.232832.44968023.davem@redhat.com>
 <20020718065355.GA2248@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:56 18/07/02, H. Peter Anvin wrote:
>Arnaldo Carvalho de Melo wrote:
>>Well, I also like the non C99 variant that is in gcc as well, but if gcc is
>>going to drop that in the future in favour of the C99 standard... But yes,
>>not having the spacing is _ugly_, what I'm doing is:
>>static struct proto_ops SOCKOPS_WRAPPED(atalk_dgram_ops) = {
>>         .family         = PF_APPLETALK,
>>         .release        = atalk_release,
>>         .bind           = atalk_bind,
>>         .connect        = atalk_connect,
>>         .socketpair     = sock_no_socketpair,
>>         .accept         = sock_no_accept,
>
>Agreed, that's the way to do it.

Yes, the patch for ntfs that just found its way into my inbox is _really_ 
ugly... Something like the above would be much nicer.

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

