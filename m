Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129567AbRBXJqc>; Sat, 24 Feb 2001 04:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129586AbRBXJqW>; Sat, 24 Feb 2001 04:46:22 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:11782 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129567AbRBXJqF>; Sat, 24 Feb 2001 04:46:05 -0500
Date: Sat, 24 Feb 2001 03:46:01 -0600
To: Pierfrancesco Caci <p.caci@tin.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unable to link 2.4.2
Message-ID: <20010224034601.C11263@cadcamlab.org>
In-Reply-To: <87pug8eaf3.fsf@penny.ik5pvx.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <87pug8eaf3.fsf@penny.ik5pvx.ampr.org>; from ik5pvx@penny.ik5pvx.ampr.org on Sat, Feb 24, 2001 at 09:45:52AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Pierfrancesco Caci]
> Hi there, can someone please tell me what's going wrong with my
> compilation of 2.4.2 ?

Change '-oformat' to '--oformat' 4 places in arch/i386/boot/Makefile.

> Binutils               2.10.91.0.2

This version of binutils no longer accepts the old 'ld -oformat' form
of '--oformat'.

Peter
