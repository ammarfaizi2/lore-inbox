Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWE2Ff5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWE2Ff5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 01:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWE2Ff5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 01:35:57 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:4773 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751202AbWE2Ff5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 01:35:57 -0400
Message-ID: <447A883C.5070604@opensound.com>
Date: Sun, 28 May 2006 22:35:56 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.2) Gecko/20060404 SeaMonkey/1.0.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Arjan van de Ven <arjan@infradead.org>, bidulock@openss7.org,
       Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: How to check if kernel sources are installed on a system?
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>	 <1148653797.3579.18.camel@laptopd505.fenrus.org>	 <20060528130320.GA10385@osiris.ibm.com>	 <1148835799.3074.41.camel@laptopd505.fenrus.org>	 <1148838738.21094.65.camel@mindpipe>	 <1148839964.3074.52.camel@laptopd505.fenrus.org>	 <1148846131.27461.14.camel@mindpipe>  <20060528224402.A13279@openss7.org> <1148878368.3291.40.camel@laptopd505.fenrus.org>
In-Reply-To: <1148878368.3291.40.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, why is Mandriva the only distro to turn OFF REGPARM?. Again, I think 
distros shouldn't be given an option to turn it off if its a good thing to have.

Are there any good reasons why REGPARM is turned off?.

------------------


Yet one more reason to have something like kernel-config (similar to gtk-config 
or xmms-config) where you can get the package's cflags, ldflags, other info.

for example

kernel-config --cflags should say -DUSE_REGPARM -I/lib/modules/blah/blah

kernel-config --libdir should say where the lib/modules/blah/blah

kernel-config --srcdir should say where the kernel sources are installed or not 
installed.

kernel-config --configsrc should configure the kernel source with the running
kernel's configuration.

kernel-config --installsrc should automatically download the RIGHT source from 
the net. Right now if you go on Ubuntu or Mandrake and you try to install kernel 
source - you get the option of stripped source, kernel-headers, kernel-2.6.blah 
which may not be installed.

Any comments?



best regards
Dev Mazumdar
-----------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA.
Tel: (310) 202 8530		URL: www.opensound.com
Fax: (310) 202 0496 		Email: info@opensound.com
-----------------------------------------------------------
