Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263951AbTDHIBf (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 04:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTDHIBf (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 04:01:35 -0400
Received: from mario.gams.at ([194.42.96.10]:18296 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id S263951AbTDHIBe convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 04:01:34 -0400
X-Mailer: exmh version 2.6.1 18/02/2003 with nmh-1.0.4
From: Bernd Petrovitsch <bernd@gams.at>
To: Miles Bader <miles@gnu.org>
cc: Daniel Egger <degger@fhm.edu>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: Re: [ANNOUNCE] New kernel tree for embedded linux 
References: <1049786306.27774.87.camel@localhost> 
In-reply-to: Your message of "08 Apr 2003 09:18:27 +0200."
             <1049786306.27774.87.camel@localhost> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Tue, 08 Apr 2003 10:12:39 +0200
Message-ID: <1358.1049789559@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger <degger@fhm.edu> wrote:
>Am Die, 2003-04-08 um 06.38 schrieb Miles Bader:
>
>> How about dealing with uClinux?  That's almost entirely embedded
>> systems.

IMHO uClinux is a workaround the problem that the standard kernel 
needs a 32bit CPU and a MMU.

>... without MMU. If you have one you better use it.

Absolutely ACK. Especially since "embedded systems" nowadays may come 
with integrated (net-)snmp agents, a web server+CGI scripts or some 
pseudo-shell for configuration, image download via tftp/ftp/http/
[xyz]modem, etc.
Then you want to use a MMU and try to convince product mgmt/whoever
to get a MMU on the device.

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


