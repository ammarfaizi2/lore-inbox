Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287244AbSBGKwb>; Thu, 7 Feb 2002 05:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287254AbSBGKwW>; Thu, 7 Feb 2002 05:52:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17216 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S287244AbSBGKwN>; Thu, 7 Feb 2002 05:52:13 -0500
To: "Daniel J Blueman" <daniel.blueman@btinternet.com>
Cc: "'Benny Sjostrand'" <gorm@cucumelo.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 512 Mb DIMM not detected by the BIOS!
In-Reply-To: <000001c1ac30$2ed408a0$0100a8c0@stratus>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Feb 2002 03:48:16 -0700
In-Reply-To: <000001c1ac30$2ed408a0$0100a8c0@stratus>
Message-ID: <m1u1st600f.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Daniel J Blueman" <daniel.blueman@btinternet.com> writes:

> Hey Benny,
> 
> This is a chipset problem. Chipsets support up to x CAS (column) lines
> and y RAS (row) lines, and depending on your DIMM memory module layout
> and configuration, you 512MB DIMM will be detected as a different sized
> module.
> 
> Eg. The venerable Intel 440BX (PII) chipset supports a max of 256MB per
> slot. Ah well.
> 
> Since it's a chipset (ie hardware) issue, it's not possible to work
> around this problem - you need a newer chipset. Sorry.

Additionally memory is generally and practically a setup once thing in
every chipset I have looked at.  Even if the chipsets supports it
would be very difficult ``fix'' this afterwards.

Eric
