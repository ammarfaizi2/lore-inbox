Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTJMVPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 17:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTJMVPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 17:15:44 -0400
Received: from [217.157.19.70] ([217.157.19.70]:4361 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S261950AbTJMVPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 17:15:43 -0400
From: Thomas Horsten <thomas@horsten.com>
To: zipa24@suomi24.fi, "Kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: SiI 3112 SATA problem with nForce2
Date: Mon, 13 Oct 2003 22:20:28 +0100
User-Agent: KMail/1.5.4
References: <3F78555B0000EE1A@webmail-fi2.sol.no1.asap-asp.net>
In-Reply-To: <3F78555B0000EE1A@webmail-fi2.sol.no1.asap-asp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310132220.28761.thomas@horsten.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 October 2003 22:04, zipa24@suomi24.fi wrote:

> Has anyone tried to use SiI 3112 SATA controller (as in Asus A7N8X
> board) with Maxtor discs?
>
> I'm using it with Maxtor 6Y160M0 and recent kernel (mostly 2.6.0-test5-mm4
> but I did try 2.6.0-test7, too) but I have problem if I torture with high
> I/O load the whole computer hangs. Sometimes it is as little has running
> "hdparm -t" on the disc but once I copied >50GB from /dev/zero to it
> without problems.

I'm using these devices and it works for me (using my Medley RAID driver). However, sometimes the system seems to hang for a while and then comes back, but it is quite rare.

I think you're waiting for Andre's DMA fix that he was going to have reviewed by SiI today, and promised out ASAP :)

In the mean time, hdparm -X 66 might help.

Regards,

Thomas

th@fireball p $ cat /proc/ide/hde/model
Maxtor 6Y080P0
th@fireball p $ cat /proc/ide/hdg/model
Maxtor 6Y080P0


