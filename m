Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310783AbSCRNXK>; Mon, 18 Mar 2002 08:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310787AbSCRNXA>; Mon, 18 Mar 2002 08:23:00 -0500
Received: from ns.suse.de ([213.95.15.193]:40209 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310783AbSCRNWn>;
	Mon, 18 Mar 2002 08:22:43 -0500
Date: Mon, 18 Mar 2002 14:22:40 +0100
From: Dave Jones <davej@suse.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Martin Dalecki <martin@dalecki.de>,
        Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [-ENOCOMPILE] ataraid as module in linux-2.5.7-pre2
Message-ID: <20020318142240.D3025@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org, Martin Dalecki <martin@dalecki.de>,
	Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200203180938.g2I9c1q27846@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 11:37:33AM -0200, Denis Vlasenko wrote:
 > gcc -D__KERNEL__ -I/.share/usr/src/linux-2.5.7-pre2/include -Wall 
 > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
 > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
 > -march=i386 -DMODULE -DMODVERSIONS -include 
 > /.share/usr/src/linux-2.5.7-pre2/include/linux/modversions.h  
 > -DKBUILD_BASENAME=ataraid  -DEXPORT_SYMTAB -c ataraid.c

 Yup, this, the Raid5 report, and a few other non-compiling bits
 are logged at http://www.codemonkey.org.uk/Linux-2.5.html

 If there's no change in those files between pre's, re-reporting
 the same non-compile errors probably isn't going to get them fixed
 any quicker 8-)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
