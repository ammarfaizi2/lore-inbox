Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268128AbUJDMqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268128AbUJDMqZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268129AbUJDMqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:46:25 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:22280 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268128AbUJDMqQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:46:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Alessandro Sappia <a.sappia@ngi.it>, linux-kernel@vger.kernel.org
Subject: Re: GPL Violation of Linux in Telsey Video Station Product
Date: Mon, 4 Oct 2004 13:44:45 +0000
X-Mailer: KMail [version 1.4]
References: <41613F2F.2000706@ngi.it>
In-Reply-To: <41613F2F.2000706@ngi.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200410041344.45700.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 October 2004 12:16, Alessandro Sappia wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Good Morning,
> I'm a Customer of a broadband ISP in Italy; They sell ont only the
> connection, but they add VoIP Phone and TVoIP. (Both TV on Demand and TV
> Broadcasting).
> I bought a Video Station branded by my carrier and surprisingly I found
> that the operating system the use is a modified version of linux.
> It was possible for me to see it because the Videostation Itself is just
> a PC with an Ethernet Card on it and it does boot from remotely.

Does it itself contain Linux? It is possible that bootstrap
tftp loader isn't Linux. In this case Videostation itself does not
contain Linux until you turn it on.

But downloading Linux kernel and GPLed software via
tftp and NFS is itself an act of distribution, and I think you
have the right to obtain source from distributor (in this case,
your ISP).

> I sniffed tftp traffic upon boot and in it it is possible to recognize
> linux, over that the / dir is mounted over NFS and it was possible for
> me to see more and more file belonging to it.
> I then asked my seller if they use linux on my VideoStation and call
> center tell me yes, but the call center people don't know where to find
> source code of their linux version.
> I contacted the the real producer of the videostation but they told me
> the the contract they have with the carrier told they sell without OS
> videostatiuons to them.
> What to do now ?

Send text of GPL to the ISP and state that you'd like to get
complete, buildable source tree for each GPLed binary component you
received over the wire.
--
vda
