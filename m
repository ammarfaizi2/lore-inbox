Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTKRAoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 19:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbTKRAoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 19:44:12 -0500
Received: from ns.media-solutions.ie ([212.67.195.98]:58383 "EHLO
	mx.media-solutions.ie") by vger.kernel.org with ESMTP
	id S262308AbTKRAoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 19:44:11 -0500
Message-ID: <3FB96AA6.8060309@media-solutions.ie>
Date: Mon, 17 Nov 2003 18:41:10 -0600
From: Keith Whyte <keith@media-solutions.ie>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: es-mx, es-es, en, en-us
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 fork & defunct child.
References: <1069053524.3fb87654286b5@ssl.buz.org> <20031117184732.GA531@louise.pinerecords.com>
In-Reply-To: <20031117184732.GA531@louise.pinerecords.com>
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RelayImmunity: 212.67.195.98
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Weird.  Totally weird.
>
>Have you checked the systems for root kits?  I'm really out of ideas
>here other than the usual hardwarehosed/systemcompromised.  One thing
>I can vouch for is Slackware 8.1 working ok as is, we've installed
>dozens of that particular release and all the machines are still
>humming away in the wild nicely.
>
>  
>
Thanks Tomas,
weird it is, it has me stumped. I'm no spring chicken with linux systems 
and i also have a slackware 8.1 system running fine on PCchips hardware 
for years. (well since slackware 8.1 came out, and before that it had 
7). But this is the only machine i've ever run a distro kernel on.

umounting /proc removes the problem.
what could be in there in proc that would be causing it? something 
misrepresented about the memory? or some other resource?


One thing i have noticed is that this happens:
kernel: PCI_IDE: unknown IDE controller on PCI bus 00 device f9, 
VID=8086, DID=24cb
kernel: PCI: Device 00:1f.1 not available because of resource collisions
on boot.

I sent some more info about the problem earlier to linux-kernel.

http://marc.theaimsgroup.com/?l=linux-kernel&m=106911546802893&w=2


thanks


