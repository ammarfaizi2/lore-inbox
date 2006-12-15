Return-Path: <linux-kernel-owner+w=401wt.eu-S1752992AbWLORWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbWLORWu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbWLORWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:22:50 -0500
Received: from web32613.mail.mud.yahoo.com ([68.142.207.240]:43328 "HELO
	web32613.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752990AbWLORWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:22:49 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 12:22:49 EST
X-YMail-OSG: o1.sMHQVM1leKt7MJz.LUbAzl0hariKpzhpkBHLNZ6KYcnt41KxPvQECjQgkTXcsTDHx95AMSwm5A_L2lZ78Zr.Tly3bxKp4KOawTLEijYFwrG__dSqBAQ--
X-RocketYMMF: knobi.rm
Date: Fri, 15 Dec 2006 09:16:09 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: [2.6.19] NFS: server error: fileid changed
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1165857788.5721.127.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <801847.80879.qm@web32613.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> 
> >  Is there a  way to find out which files are involved? Nothing
> seems to
> > be obviously breaking, but I do not like to get my logfiles filled
> up. 
> 
> The fileid is the same as the inode number. Just convert those
> hexadecimal values into ordinary numbers, then search for them using
> 'ls
> -i'.
> 
> Trond
> 
> > [ 9337.747546] NFS: server nvgm022 error: fileid changed
> > [ 9337.747549] fsid 0:25: expected fileid 0x7a6f3d, got 0x65be80
Hi Trond, 

 just curious: how is the fsid related to mounted filesystems? What
does "0:25" stand for?

Cheers
Martin

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
