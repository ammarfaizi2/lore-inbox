Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbTJJGV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 02:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbTJJGV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 02:21:56 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:34946 "HELO
	longlandclan.hopto.org") by vger.kernel.org with SMTP
	id S262507AbTJJGVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 02:21:54 -0400
Message-ID: <3F864F82.4050509@longlandclan.hopto.org>
Date: Fri, 10 Oct 2003 16:19:46 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: lgb@lgb.hu, Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be>	<20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com>
In-Reply-To: <20031009165723.43ae9cb5.skraw@ithnet.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephan von Krawczynski wrote:
> * hotplug CPU
> * hotplug RAM

* hotplug motherboard & entire computer too I spose ;-)

Although sarcasm aside, a couple of ideas that have been bantered around 
on this list (and a few of my own ideas):

	- /proc interface alternative to modutils/module-init-tools.

		That is, to have a directory of virtual nodes in /proc
		to provide the functionality of insmod, rmmod, lsmod &
		modprobe would be great -- especially from the viewpoint
		of recue disk images, etc.

	- Software RAID 0+1 perhaps?

		A lot of hardware RAID cards support it, why not the
		kernel?  By RAID 0+1 I mean mirror-RAIDing two (or more) 		stripe-RAID 
arrays.  (Or can this be done already?)

	- Transparent Software-RAID for IDE RAID cards...
		This could be done by using the Software RAID
		functionality of the kernel, but making the RAID
		interface transparent, so you only see a /dev/md?
		device, rather than multiple /dev/?da* entries.

	- Support for the Casio DV-01 USB digital notetaker.

Just some thoughts...
And I spose, a few people have mentioned this already, what is planned 
for Linux 3.0?
- -- 
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Griffith Student No:           Course: Bachelor/IT (Nathan) |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/hk+GIGJk7gLSDPcRArgVAJ0ZPJMRkMiFrGBBVVmL180fuZq2AACdFpCh
XjqIDsrAfvIYZgxipX3THdY=
=mRNi
-----END PGP SIGNATURE-----

