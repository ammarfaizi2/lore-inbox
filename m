Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311147AbSDITmx>; Tue, 9 Apr 2002 15:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311206AbSDITmw>; Tue, 9 Apr 2002 15:42:52 -0400
Received: from stingr.net ([212.193.32.15]:27008 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S311147AbSDITmw>;
	Tue, 9 Apr 2002 15:42:52 -0400
Date: Tue, 9 Apr 2002 23:42:48 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] 2.4.19-pre5-ac3-s43
Message-ID: <20020409194248.GB523@stingr.net>
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

=== Linux 2.4.19-pre5-ac3-s43 kernel is out.

This is (as usual) CUSTOM TEST KERNEL with USE AT YOUR OWN RISK big letters
printed everywhere on it but ...
but it survived some LTPs here (unlike radix tree pagecache patch) and it at
least will go onto some production servers here (if not explodes :))

=== Introduction

My matchset is just another 2 cents to the overall chaos.

-stingr kernel has many uses. For example, it can be used on transparent
proxies and routers - because it always contain latest netfilter enhancements 
and suitable to run as single-nic (vlan) firewall.

=== Getting it from hostme.bitkeeper.com.

bk clone bk://linux-stingr.bkbits.net/stable4
-or-
bk clone -rv2.4.19-pre5 any-marcelo-tree stingr &&
cd stingr &&
bk pull bk://linux-stingr.bkbits.net/stable4

=== Getting it as a patch.

http://stingr.net/l/2.4.19pre5ac3-to-stingr43.bz2
ftp://stingr.net/pub/l/2.4.19pre5ac3-to-stingr43.bz2

=== Table of contents
Fundamental:
	linux-2.4.19-pre5-ac3			(Alan Cox)

Fixes to -ac3:
	Make swsusp actually work (2 patches)	(Pavel Machek)
	Wrap software_suspend in #ifdefs	(me)
	| somewhere in acpi/ospm/system to
	| avoid missing symbol	      		
	vm86 fixes				(Kasper Dupont)
	
Enhancements:
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

I'm not including ratpagecache for now due it's bugs I mentioned in my
previous postings to l-k.

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
