Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262334AbTCMN1n>; Thu, 13 Mar 2003 08:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262335AbTCMN1n>; Thu, 13 Mar 2003 08:27:43 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:25234 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S262334AbTCMN1k>; Thu, 13 Mar 2003 08:27:40 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: Torsten Foertsch <torsten.foertsch@gmx.net>,
       "Jeremy Booker" <JerMe@nc.rr.com>
Subject: Re: initrd / pivot_root + boot problems
Date: Thu, 13 Mar 2003 14:38:08 +0100
User-Agent: KMail/1.5
Cc: <linux-kernel@vger.kernel.org>
References: <002801c2e8ea$46aadfb0$6401a8c0@jeremy> <200303130829.29989.torsten.foertsch@gmx.net>
In-Reply-To: <200303130829.29989.torsten.foertsch@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303131438.08371.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 March 2003 08:29, Torsten Foertsch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Wednesday 12 March 2003 23:54, Jeremy Booker wrote:
> > kernel /boot/vmlinuz-2.4.7-10 ro root=/dev/sda1
>
> append to that line "init=/bin/bash" then boot. You will see a bash prompt.
> Now mount whatever is necessary, change your passwd and reboot. Maybe, you
> need a "mount -o remount,rw /" prior to changing pw.
>
And before rebooting you should also run "sync" ;-) otherwise everything you 
have written to the harddisk (including your password file) would be probably 
lost.

Bernd
