Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264023AbRFMP4O>; Wed, 13 Jun 2001 11:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264024AbRFMPzy>; Wed, 13 Jun 2001 11:55:54 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:44975 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264023AbRFMPzn>; Wed, 13 Jun 2001 11:55:43 -0400
Message-ID: <3B273A20.8EE88F8F@vnet.ibm.com>
Date: Wed, 13 Jun 2001 05:02:08 -0500
From: Tom Gall <tom_gall@vnet.ibm.com>
X-Mailer: Mozilla 4.7 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Going beyond 256 PCI buses
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<Forgive if this is a dub... but the message I composed yesterday didn't
appear to be posted>

  Anyway, Hi All,

  I was wondering if there are any other folks out there like me who
have the 256 PCI bus limit looking at them straight in the face? If so,
it'd be nice to collaborate and come up with a more general solution
that would hopefully work towards the greater good.

  I live in ppc64 land which is a new arch that the linux kernel has
been ported to. The boxes we run on tend to be big.

  The box that I'm wrestling with, has a setup where each PHB has an
additional id, then each PHB can have up to 256 buses.  So when you are
talking to a device, the scheme is phbid, bus, dev etc etc. Pretty easy
really.

  I am getting for putting something like this into the kernel at large,
it would probably be best to have a CONFIG_GREATER_THAN_256_BUSES or
some such.

  Anyways, thoughts? opinions?

--
Hakuna Matata,

Tom

-----------------------------------------------------------
ppc64 Maintainer     IBM Linux Technology Center
"My heart is human, my blood is boiling, my brain IBM" -- Mr Roboto
tgall@rochcivictheatre.org
tom_gall@vnet.ibm.com


