Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRBMSfb>; Tue, 13 Feb 2001 13:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129114AbRBMSfW>; Tue, 13 Feb 2001 13:35:22 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:57870 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S129065AbRBMSfF>; Tue, 13 Feb 2001 13:35:05 -0500
Date: Tue, 13 Feb 2001 13:34:55 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>, Frank Davis <fdavis112@juno.com>
Subject: Re: 2.4.1-ac10 compile error
Message-ID: <Pine.LNX.4.33.0102131326210.14002-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Keith!

I also noticed this error when I upgraded from ac9 to ac11.

My understanding is that if "make depend" is run on the sources that have
already been compiled, then names.o depends on devlist.h (with full path)
is ".depend".

If I run "make clean" first, then everything is fine. But I think that
something must have been broken in ac10. I'm always running "make clean"
after "make depend" and it's the first time that I have a problem with it.

Regards,
Pavel Roskin

