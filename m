Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWC1I3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWC1I3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWC1I3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:29:43 -0500
Received: from mail.cc.tut.fi ([130.230.1.120]:25301 "EHLO outbox.tut.fi")
	by vger.kernel.org with ESMTP id S1751377AbWC1I3m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:29:42 -0500
Date: Tue, 28 Mar 2006 11:29:39 +0300
From: Petri Kaukasoina <kaukasoina512mxtg1n@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: hda-intel woes
Message-ID: <20060328082938.GA10902@elektroni.phys.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060327231049.GA30641@localhost.in.y0ur.4ss>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20060327231049.GA30641@localhost.in.y0ur.4ss>
User-Agent: Mutt/1.4.2.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 01:10:49AM +0200, Friedrich Göpel wrote:
> I tried Fedora FC4, FC5 test 3 and now Gentoo with various kernel and
> alsa versions (specifically 1.0.10 and 1.0.11-rc3 and whatever is in
> fedora before and after a full update).

> Anyways the damn thing is not to be convinced to produce a single
> sound.

Hi

Try kernel 2.6.15.* from kernel.org and the ALSA drivers coming with it. At
least it works on my HP Compaq.

kernel 2.6.15.6 (with builtin ALSA 1.0.10rc3) works fine
kernel 2.6.16 + its ALSA (1.0.11rc2): no sound
kernel 2.6.16 + alsa-git-2006-03-22.patch (ALSA 1.0.11rc4): no sound


00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 01)
        Subsystem: Hewlett-Packard Company: Unknown device 3010

Codec: Realtek ALC260
Vendor Id: 0x10ec0260
Subsystem Id: 0x103c3010
Revision Id: 0x100400



-Petri
