Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVARPUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVARPUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVARPUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:20:16 -0500
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:55682 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S261318AbVARPUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:20:11 -0500
Date: Tue, 18 Jan 2005 16:20:06 +0100
From: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>
To: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118152006.GJ2839@darkside.22.kls.lan>
Mail-Followup-To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>,
	Sytse Wielinga <s.b.wielinga@student.utwente.nl>,
	linux-kernel@vger.kernel.org
References: <2E314DE03538984BA5634F12115B3A4E01BC42AE@email1.mitretek.org> <20050118140203.GH2839@darkside.22.kls.lan> <20050118141707.GA11385@speedy.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118141707.GA11385@speedy.student.utwente.nl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 03:17:07PM +0100, Sytse Wielinga wrote:
> Why not just use dd if=/dev/xxx `blockdev --getbsz /dev/xxx` ...?

because it doesn't work, as I've demonstrated in
Message-ID: <20050118082022.GA2839@darkside.22.kls.lan>

> root@darkside:~# dd if=/dev/hdg7 of=/dev/null bs=512
> attempt to access beyond end of device
> 22:07: rw=0, want=4996184, limit=4996183
> dd: reading `/dev/hdg7': Input/output error
> 9992360+0 records in
> 9992360+0 records out
> 5116088320 bytes transferred in 92,603241 seconds (55247400 bytes/sec)
> root@darkside:~#
> 
> Fixing dd's blocksize to 512 doesn't help either.


-- 
*axiom* welcher sensorische input bewirkte die output-aktion,
        den irc-chatter mit dem nick "dus" des irc-servers
        mittels eines kills zu verweisen?
