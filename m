Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313467AbSDLIuo>; Fri, 12 Apr 2002 04:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313468AbSDLIuo>; Fri, 12 Apr 2002 04:50:44 -0400
Received: from stingr.net ([212.193.32.15]:56194 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S313467AbSDLIum>;
	Fri, 12 Apr 2002 04:50:42 -0400
Date: Fri, 12 Apr 2002 12:50:37 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] 2.4.19-pre5-ac3-s45
Message-ID: <20020412085037.GB28338@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently updated -stingr series kernel to version s45. This will add a
couple of wli's hashes, parts from -aa tree, large (>2G) file support to
smbfs, and Ingo's irqrate.

This is currently installed on my proxy server and now I have CPU usage
reduced from excessive to reasonable value (50%). I believe credits for this
improvements should go to wli.

=== Getting it from hostme.bitkeeper.com.

bk clone bk://linux-stingr.bkbits.net/stable4
-or-
bk clone -rv2.4.19-pre5 any-marcelo-tree stingr &&
cd stingr &&
bk pull bk://linux-stingr.bkbits.net/stable4

=== Getting it as a patch.

http://stingr.net/l/2.4.19pre5ac3-to-stingr45.bz2
ftp://stingr.net/pub/l/2.4.19pre5ac3-to-stingr45.bz2

=== Getting required software

http://www.hojdpunkten.ac.se/054/samba/index.html
http://netfilter.samba.org

=== Table of contents (* - new to this release)

Fundamental:
	linux-2.4.19-pre5-ac3			(Alan Cox)

Fixes to -ac3:
	Make swsusp actually work (2 patches)	(Pavel Machek)
	Wrap software_suspend in #ifdefs	(me)
	| somewhere in acpi/ospm/system to
	| avoid missing symbol	      		
	vm86 fixes				(Kasper Dupont)
	
Enhancements:
*	{{d,i,b,page}cache,{p,u}id}_hash.patch	(William Lee Irwin III)
*	00_{VM_IO-3,o_direct-open-check-1,	(Andrea Arcangeli)
	| binfmt-elf-checks-1,sr-scatter-pad-1}
*	00-smbfs-2.4.18-{codepage,	       	(Urban Widmark)
	| lfs,unicode}.patch, you need patched
	| smbmount to use it
*	irqrate	      	    			(Ingo Molnar)

	path_lookup - simple precursor to 	(Hanna Linder)
	| fast_walk
	Almost all nonconflicting ones from	(Netfilter team)
	| latest netfilter patch-o-matic
	| (you need cvs version of iptables)
	| changed default policy NOT to log
	| out_of_window packets
	Netfilter support for eth brigding  	(Lennert Buytenhek)
	Devfs v199.11	      	  		(Richard Gooch)
	EVMS 1.0.0				(Kevin Corry)
	| EVMS fixes for O1 sched compatibility	(me)
	Tulip & eepro100 patches to allow
	| oversized frames	    	 	(me)
	/dev/epoll  				(Davide Libenzi)
	reiserfs quota support			(?)
	netfilter zerocopy path patch		(?)
	task_t.state cleanup			(me)
	alternate ip_conntrack hash function	(me)
	| and allocation
	printk -> DPRINTK converted in atm	(me)
	| code somewhere

Declined enhancements:
	Radix tree pagecache			(Momchil Velikov)
	      	   				(Cristoph Hellwig)
						(Art Haas)


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
