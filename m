Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUBMHQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 02:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUBMHQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 02:16:05 -0500
Received: from hera.kernel.org ([63.209.29.2]:37526 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266807AbUBMHQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 02:16:02 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Date: Fri, 13 Feb 2004 07:15:37 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0htip$gf1$1@terminus.zytor.com>
References: <200402112344.23378.rototor@rototor.de> <20040213070333.GA1555@intern.kubla.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1076656537 16866 63.209.29.3 (13 Feb 2004 07:15:37 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 13 Feb 2004 07:15:37 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040213070333.GA1555@intern.kubla.de>
By author:    Dominik Kubla <dominik@kubla.de>
In newsgroup: linux.dev.kernel
>
> On Wed, Feb 11, 2004 at 11:44:23PM +0000, Emmeran Seehuber wrote:
> > Hello everybody!
> > 
> > I'm trying to switch my laptop from kernel 2.4 to kernel 2.6.2. Everything 
> > seems to work correctly, only my PS/2 mouse doesn't.
> 
> Seconded. After update from 2.6.0 to 2.6.2 both the built-in touchpad and
> stick stopped working. XFree86 complained about "no such device" (or something
> similiar) when accessing /dev/psaux. /dev/input/mice is also configured but
> seems not to work.
> 
> Hardware is a Dell Inspiron 8000.
> 

I've seen the same on a Transmeta development platform, which is
designed to "look like" a laptop.  Makes me wonder if there is some
interaction with ACPI.

	-hpa

-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bahá'u'lláh
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!
