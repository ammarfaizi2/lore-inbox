Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVAEPyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVAEPyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVAEPxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:53:44 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:14807 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S262475AbVAEPiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:38:54 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10 TCP troubles
Date: Wed, 05 Jan 2005 15:14:20 GMT
Message-ID: <0508KZW12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> Mail agent comments:
>   Sending server is suspicious.
> 
> On Mer, 2005-01-05 at 12:50, Hubert Tonneau wrote:
> > troubles (probably lost packets on the Mac side because the Linux machine is
> > gigabit connected to the switch, with flow control enabled, and the Mac is
> > 100 Mbps connected, full duplex, but without flow control).
> 
> Through a firewall ?

No:

Mac <-> 100 Mbps switch <-> gigabit switch <-> Linux

One possible explaination, even if unlikely, might be that Linux 2.6.10 is
faster than 2.6.8, so the Mac start missing packets.

If you want me to make tests, I can switch back to 2.6.10 at night, perform
tests, and switch back to 2.6.8 before production resumes in the morning.

