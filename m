Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVAGTXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVAGTXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVAGTXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:23:24 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:16143 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261541AbVAGTR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:17:56 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Javier Villavicencio <javierv@migraciones.gov.ar>,
       Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: no entropy and no output at /dev/random (quick question)
Date: Fri, 7 Jan 2005 21:17:45 +0200
User-Agent: KMail/1.5.4
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
References: <200411301249.iAUCnJgs004281@laptop11.inf.utfsm.cl> <41ACA45B.206@migraciones.gov.ar>
In-Reply-To: <41ACA45B.206@migraciones.gov.ar>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501072117.45959.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 November 2004 18:48, Javier Villavicencio wrote:
> > Reading /dev/urandom depletes exactly the same pool, it just doesn't block
> > when the pool is empty. As said pool has other uses, indiscriminate reading
> > of either can DoS other parts of the system.
> 
> But why if /dev/random depletes and you don't have any source of entropy 
> ? As you may have seen in my setup I had no mouse/keyboard attached to 
> that server, and the only "things" capable of generate entropy where the 
> two nics and the DAC960.
> So I've enabled entropy only for the local nic and the DAC960 (at least 
> "I think", for the dac :+) and now I'm plenty of entropy, but for a 
> setup like this, the server may have been running without entropy at all 
> for weeks (I've forgot to check the uptime :+P).
> About this, think about php generating session_id()s without entropy 
> (o_O), and stuff like that....

BTW why your php developer can't use /dev/urandom?
--
vda

