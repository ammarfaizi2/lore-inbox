Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTAJLzU>; Fri, 10 Jan 2003 06:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTAJLzU>; Fri, 10 Jan 2003 06:55:20 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:48588 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S261353AbTAJLzU> convert rfc822-to-8bit;
	Fri, 10 Jan 2003 06:55:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Wolfgang Fritz <wolfgang.fritz@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [Asterisk] DTMF noise
Date: Fri, 10 Jan 2003 13:03:50 +0100
User-Agent: KMail/1.4.1
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net> <3E1D705E.1030203@sktc.net> <3E1D79CB.5010503@gmx.net>
In-Reply-To: <3E1D79CB.5010503@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301101303.50046.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My simple patch added a relative energy comparision of the DTMF tones
> and a simple plausibiltity check (DTMF is only accepted if there is
> exactly one DTNF pair and no/low signal level on the other DTMF
> frequencies. That worked with my (very limited) tests.

I'm not sure if we're at the source of the problem. I mean - it should be 
possible to set a minimum length as well, so just touching a key won't be 
accepted. I beleive this'll remove most of the falsly detected dtmf signals 
as well, as noone really holds the same tone for a long time while speaking

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

