Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbTI0NYC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 09:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTI0NYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 09:24:02 -0400
Received: from cust.92.136.adsl.cistron.nl ([195.64.92.136]:28421 "EHLO
	purgatory.unfix.org") by vger.kernel.org with ESMTP id S262440AbTI0NX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 09:23:58 -0400
From: "Jeroen Massar" <jeroen@unfix.org>
To: "'Alexey V. Yurchenko'" <ayurchen@mail.emicnetworks.com>,
       "'Stephen Hemminger'" <shemminger@osdl.org>
Cc: <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: how to set multicast MAC ligitemately?
Date: Sat, 27 Sep 2003 15:23:54 +0200
Organization: Unfix
Message-ID: <001701c384fa$99d61360$210d640a@unfix.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20030927160445.6ff09796.ayurchen@mail.emicnetworks.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

Alexey V. Yurchenko wrote:

> On Fri, 26 Sep 2003 12:03:45 -0700
> Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > 
> > Not interface should have a multicast MAC address. A 
> multicast address
> > should only exist as a destination address, never a source.
> 
> Well, that's in theory. In practice I need several computers 
> connected to a switch to share a single interface and look to 
> the rest of LAN as a single node. All those computers must 
> receive all packets desitned to that interface. Using 
> non-multicast MAC confuses many switches.
> 
> Any suggestions? (Except not using a switch ;))

Enable the ports to be mirror ports and then they will get
all the traffic targetted at the switch.
But you do have to have a real switch to support that feature ;)

Greets,
 Jeroen

-----BEGIN PGP SIGNATURE-----
Version: Unfix PGP for Outlook Alpha 13 Int.
Comment: Jeroen Massar / jeroen@unfix.org / http://unfix.org/~jeroen/

iQA/AwUBP3WPYSmqKFIzPnwjEQI0qQCfVKaVANvW1H3SnLe6zV7PWYil6QUAnA5z
/CGLoEVQG7l3FqaVp6Ulba9l
=0zfR
-----END PGP SIGNATURE-----

