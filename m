Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUCHFRx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 00:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbUCHFRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 00:17:53 -0500
Received: from mail.zero.ou.edu ([129.15.0.75]:39092 "EHLO c3p0.ou.edu")
	by vger.kernel.org with ESMTP id S261706AbUCHFRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 00:17:51 -0500
Date: Sun, 07 Mar 2004 18:07:13 -0600
From: "Stephen M. Kenton" <skenton@ou.edu>
Subject: Re: new special filesystem for consideration in 2.6/2.7
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <404BB931.1D3C83E8@ou.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en]C-CCK-MCD NSCPCD47  (Win98; I)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If the recent news about giga-bit mram being a real possibility in
>> the not too far future pans out, this may be get more important.

>This is a reality in embedded devices.  Go read the message again...

Umm, yes and no.  I did not mean to dis this proposal because I think it
is worthwhile.  Rather, I was thinking about the problems with really
large amounts of data.  I don't really think that a few Kilo or Mega
bytes of data  needs the same sort of infrastructure that will be
required
for Tera or Peta bytes.  As an extreme example the few bytes of nv ram
in the
cmos clock chips in the original PC/AT did not require much support
while
the multiple terabytes of data in my raid farm at work would be very
vulnerable under this proposal since a rogue process could cause lots of
damage in very sort order as would losing a memory bank to hardware
failure.

In the last discussion I saw on the topic on lkml, there was discussion
about
whether to even preserve the volume/directory/file abstraction at all
for
memory mapped data spaces.  That discussion was quite speculative given
the lack of affordable *really large* nvram type storage to compete with
100+ gigabyte disks and even larger raids.  That situation may be
changing.
Hence, this may become more important.

smk
