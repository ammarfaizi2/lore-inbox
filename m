Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271454AbTGQM6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 08:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271455AbTGQM6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 08:58:54 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:30980 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S271454AbTGQM6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 08:58:53 -0400
From: Ian Hastie <lkml@ordinal.freeserve.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 sound drivers?
Date: Thu, 17 Jul 2003 14:13:43 +0100
User-Agent: KMail/1.5.2
References: <20030716225826.GP2412@rdlg.net> <3F15F63E.1060602@pobox.com> <200307162318.27081.nbensa@gmx.net>
In-Reply-To: <200307162318.27081.nbensa@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307171413.45472.lkml@ordinal.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 Jul 2003 03:18, Norberto BENSA wrote:
> Jeff Garzik wrote:
> > Max Valdez wrote:
> > > I have a SBlive too, emu10k1 works pretty well for me, what should I do
> > > for going to ALSA ??
> >
> > ALSA supports emu10k1.
>
> How well? Last time I've checked ALSA, it didn't support bass and treble,
> that's why I'm using OSS (emu10k1)

ALSA's support seems usable, but still doesn't allow you to programme the DSP 
with your own code.  OSS uses this to enable such things as bass and treble 
controls, as well as a selection of audio effects with code provided.  Anyone 
know if ALSA will allow this kind of thing in the future?

-- 
Ian.

