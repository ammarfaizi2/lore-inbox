Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbVCWJTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbVCWJTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbVCWJTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:19:38 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:6 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262888AbVCWJT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:19:29 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: 7eggert@gmx.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Samsung 40G drive locking up 2.6.11
Date: Wed, 23 Mar 2005 11:19:04 +0200
User-Agent: KMail/1.5.4
References: <fa.gg9u7j2.1vm65hi@ifi.uio.no> <E1DDkGQ-0000t8-9g@be1.7eggert.dyndns.org>
In-Reply-To: <E1DDkGQ-0000t8-9g@be1.7eggert.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503231119.05084.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 March 2005 16:21, Bodo Eggert wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> 
> > dd if=/dev/hdc of=/dev/null with this disk
> > kills the system. Drive may do it's work
> > for minute or two, but then it does 'klak' sound.
> 
> Did you try shdiag or hutil from samsung.com?

No. I am not worried about driver being possibly defective etc.
This happens. I am mostly unhappy with this possibly defective
drive being able to solidly lock up a Linux system!
(Linux is on *hda*, I don't think it's ok for IO problems
on *hdc* to affect hda and overall system stability).

Unfortunately, the disk promptly stopped misbehaving.
I'll keep an eye on it, tho.
--
vda

