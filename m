Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317378AbSGXQHi>; Wed, 24 Jul 2002 12:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317388AbSGXQHi>; Wed, 24 Jul 2002 12:07:38 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:2954
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S317378AbSGXQHg>; Wed, 24 Jul 2002 12:07:36 -0400
Date: Wed, 24 Jul 2002 12:19:53 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DAC960 Bitrot
Message-ID: <20020724121953.B20482@animx.eu.org>
References: <Pine.LNX.4.44L.0207101741380.14432-100000@imladris.surriel.com> <E17Sai1-0002T7-00@starship> <20020711100828.GE808@suse.de> <E17WlGV-00052g-00@starship> <20020724143931.GG5159@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20020724143931.GG5159@suse.de>; from Jens Axboe on Wed, Jul 24, 2002 at 04:39:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well not really, DAC960 is still using the default per-major queues. But
> switching to per-device queue would definitely be a Really Good Idea.
> The only changes I did to this driver where trivial conversions in the
> 2.5.1-pre days, in fact even before multi-page bio's existed. This,

I'd like to make a suggestion which actually doesn't pertain to the original
thread, but since this is being read, I thought it would be a good place.

Why not add a configure option to disable firmware checking?  I have a few
cards here with firmware 2.x x < 73 and they work fine (disabled the check).

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
