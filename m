Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTFTNiC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTFTNiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:38:02 -0400
Received: from sarge.hbedv.com ([217.11.63.11]:50413 "EHLO sarge.hbedv.com")
	by vger.kernel.org with ESMTP id S261757AbTFTNiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:38:01 -0400
Date: Fri, 20 Jun 2003 15:51:55 +0200
From: Wolfram Schlich <lists@schlich.org>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.4.21+pppoe
Message-ID: <20030620135155.ALLYOURBASEAREBELONGTOUS.C15622@bla.fasel.org>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20030620001313.2f8e3279.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620001313.2f8e3279.pochini@shiny.it>
Organization: Axis of Weasel(s)
X-Accept-Language: de, en, fr
X-GPG-Key: 0xCD4DF205 (http://wolfram.schlich.org/wschlich.asc, x-hkp://wwwkeys.de.pgp.net)
X-GPG-Fingerprint: 39EC 98CA 4130 E59A 1041  AD06 D3A1 C51D CD4D F205
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled Mar 24 2002 15:02:51)
X-Face: |P()Q^fx-{=,K-3g?5@Id4o|o{Xf_5v:z3WIhR3fOW-$,*=[#[Qq<,@P!OsXbR|i6n=]B<3mzGC++F@K#wvoLEnIZuTR6wPCMQfxq!';9w[TiP3Bhz"r&$7eGFq7us@Z5Qd$3W[3W3:U7biTNZgf"<]LqwS
X-Operating-System: Linux prometheus 2.4.21-grsec-1.9.10 #1 SMP Fre Jun 20 03:31:36 CEST 2003 i686 unknown
X-Uptime: 3:49pm up 11:56, 2 users, load average: 0.09, 0.16, 0.11
User-Agent: Mutt/1.5.4i
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.11; AVE: 6.20.0.1; VDF: 6.20.0.14; host: mx.bla.fasel.org)
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.11; AVE: 6.20.0.1; VDF: 6.20.0.14; host: mail.bla.fasel.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Giuliano Pochini <pochini@shiny.it> [2003-06-20 00:17]:
> When a pppoe connection is up, any change to the ethernet config causes an
> oops. In this case I did "ifconfig eth0 down", but it also oopses if I add
> a secondary address. These are two oopses caused by the command above:
> [...]

That's not specific to 2.4.21 - I had this problem with older 2.4
Kernels as well. I guess it's a bug in pppd, not the Kernel or its
PPPOE implementation. No kind of proof though :)
-- 
Wolfram Schlich; Friedhofstr. 8, D-88069 Tettnang; +49-(0)178-SCHLICH
