Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292983AbSCFBk2>; Tue, 5 Mar 2002 20:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292989AbSCFBkS>; Tue, 5 Mar 2002 20:40:18 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:43528
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S292983AbSCFBkI>; Tue, 5 Mar 2002 20:40:08 -0500
Date: Wed, 6 Mar 2002 02:40:01 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: =?iso-8859-1?Q?Hanno_B=F6ck?= <hanno@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic
Message-ID: <20020306024001.A9217@bouton.inet6-interne.fr>
Mail-Followup-To: =?iso-8859-1?Q?Hanno_B=F6ck?= <hanno@gmx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020305233141.3f438954.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020305233141.3f438954.hanno@gmx.de>; from hanno@gmx.de on Tue, Mar 05, 2002 at 11:31:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 11:31:41PM +0100, Hanno Böck wrote:
> I have a PC with an Athlon CPU, which has problems with newer kernel-versions. (see lspci-output below)
> 
> If I want to boot current Knoppix or Mandrake 8.2beta3 install cds (both based on kernel 2.4.17), it says:
> 
> Kernel panic: VFS: Unable to mount root fs on 03:05
> 
> It worked fine with the older mandrake 8.1 with kernel 2.4.8.
> 
> Any ideas? How can I help to fix this?
> 

Try passing ide=nodma during install and following reboot(s) then fetch a patch
at:
http://inet6.dyn.dhs.org/sponsoring/sis5513/index.html
, apply, recompile, install.

SiS730 support should be OK with latest patches.

LB.
