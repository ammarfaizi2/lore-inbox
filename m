Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbUCCOMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 09:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUCCOMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 09:12:21 -0500
Received: from styx.suse.cz ([82.208.2.94]:18306 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S262390AbUCCOMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 09:12:20 -0500
Date: Wed, 3 Mar 2004 15:12:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-bk7 i8042 does not work on a genuine i386 ibm ps/2 model 70.
Message-ID: <20040303141218.GA12327@ucw.cz>
References: <m1znb29css.fsf@ebiederm.dsl.xmission.com> <20040303101347.GB310@ucw.cz> <20040303140513.GX19111@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303140513.GX19111@khan.acc.umu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 03:05:13PM +0100, David Weinehall wrote:

> [snip]
> 
> > Does the machine by any chance have a PS/2 mouse port? If not, it may be
> > the reason - it would have an AT-style i8042, and those might not be
> > implementing that bit.
> 
> ALL PS/2's have PS/2 mouse ports.  Guess where the name comes from...

I thought so, but the driver also assumes that all PS/2's follow the IBM
PS/2 keyboard controller spec, which they obviously don't.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
