Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292958AbSCAM4M>; Fri, 1 Mar 2002 07:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293226AbSCAM4C>; Fri, 1 Mar 2002 07:56:02 -0500
Received: from ns.suse.de ([213.95.15.193]:54791 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293214AbSCAMzt>;
	Fri, 1 Mar 2002 07:55:49 -0500
Date: Fri, 1 Mar 2002 13:55:48 +0100
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Paul Gortmaker <p_gortmaker@yahoo.com>,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluesmoke/MCE support optional
Message-ID: <20020301135547.F7662@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mike Fedyk <mfedyk@matchmail.com>,
	Paul Gortmaker <p_gortmaker@yahoo.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020301024710.GF2711@matchmail.com> <E16gmBy-0003V5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16gmBy-0003V5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 01, 2002 at 12:31:18PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 12:31:18PM +0000, Alan Cox wrote:
 > > > +  ranging from a warning message on the console, to halting the machine.
 > > > +  Your processor must be a Pentium or newer to support this - check the 
 > > > +  flags in /proc/cpuinfo for mce.  Note that some older Pentium systems
 > > > +  have a design flaw which leads to false MCE events - for these and
 > > > +  old non-MCE processors (386, 486), say N.  Otherwise say Y.
 > 
 > Its not necessary to say N. On a pentium box with the newer MCE setup code
 > you must force MCE on. On non MCE capable CPU's we just dont set it up.

 The help text should probably document the nomce boot option too.

 btw, anyone else posting in this thread getting crap like..
 http://www.codemonkey.org.uk/duhhh.txt  ?
 I've got them from two different threads now, which is starting
 to get annoying.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
