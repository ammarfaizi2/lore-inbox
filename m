Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbTADMwV>; Sat, 4 Jan 2003 07:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266898AbTADMwV>; Sat, 4 Jan 2003 07:52:21 -0500
Received: from smtp01.fields.gol.com ([203.216.5.131]:51683 "EHLO
	smtp01.fields.gol.com") by vger.kernel.org with ESMTP
	id <S266865AbTADMwV>; Sat, 4 Jan 2003 07:52:21 -0500
To: "Andrey Panin" <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] irq handling code consolidation, second try (v850 part)
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
From: Miles Bader <miles@gnu.org>
Date: 04 Jan 2003 22:00:29 +0900
Message-ID: <87hecp83yq.fsf@tc-1-100.kawasaki.gol.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't test it, but the v850 part looks great, ah, it's lovely to see all
that code being deleted...

One comment:  `arch_check_irq' is a bad name, it doesn't make it at all
clear what it does.

I might suggest inverting the sense, and using `irq_valid' -- the `arch_'
prefix seems unnecessary (as with `irq_desc') since it's not a
arch-specific version of a more general wrapper.

Thanks,

-Miles

-- 
Quidquid latine dictum sit, altum viditur.
