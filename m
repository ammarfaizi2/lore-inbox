Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313179AbSEIOdZ>; Thu, 9 May 2002 10:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSEIOdY>; Thu, 9 May 2002 10:33:24 -0400
Received: from ns.suse.de ([213.95.15.193]:17413 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313179AbSEIOdY>;
	Thu, 9 May 2002 10:33:24 -0400
Date: Thu, 9 May 2002 16:33:23 +0200
From: Dave Jones <davej@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.14-dj2
Message-ID: <20020509163323.A5262@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Adrian Bunk <bunk@fs.tum.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020508225147.GA11390@suse.de> <Pine.NEB.4.44.0205091140100.19321-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 11:46:48AM +0200, Adrian Bunk wrote:
 > irlmp.c:1302: redefinition of `irlmp_flow_indication'
 > irlmp.c:1236: `irlmp_flow_indication' previously defined here
 > {standard input}: Assembler messages:
 > {standard input}:2987: Error: symbol `irlmp_flow_indication' is already
 > It seems that the changes to irlmp.c were merged by Linus but not removed
 > from the -dj patch. Unfortunately the context of this patch allows to
 > apply it several times...
 > The following patch needs to be removed from -dj:

Yup, thanks.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
