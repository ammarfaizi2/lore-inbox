Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbTJSTkG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTJSTkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:40:00 -0400
Received: from main.gmane.org ([80.91.224.249]:64427 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262224AbTJSTj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:39:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: HighPoint 374
Date: Sun, 19 Oct 2003 21:39:52 +0200
Message-ID: <yw1xy8vhf247.fsf@users.sourceforge.net>
References: <00b801c3955c$7e623100$0514a8c0@HUSH> <1066579176.7363.3.camel@milo.comcast.net>
 <41102.192.168.9.10.1066584247.squirrel@ncircle.nullnet.fi>
 <yw1x3cdpgm46.fsf@users.sourceforge.net>
 <48232.192.168.9.10.1066590873.squirrel@ncircle.nullnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:Womf2mjg5qNluhBzVzSDtoj4ilA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi> writes:

>> I'm using a RocketRAID 1540 SATA card (hpt374 based) in an Alpha
>> system.  It has no such thing as ACPI.  The disks are four Seagate
>> Barracuda 7200.7 running software raid5.  My /proc/interrupts:
>
> Ok, that might be one reason why it's working for you but not for me.
> If I've understood correctly, people who have problems with HPT374
> are using the integrated Parallel-ATA interface instead of SATA.

The chip on the SATA controller is the same as the PATA version.  The
SATA interface is handled by external bridge chips.  I don't really
see how it would make any difference if the hpt374 is on a PCI board
on on the motherboard.  The Alpha system is quite different from your
average PC in some ways, though.  That could explain some differences.

-- 
Måns Rullgård
mru@users.sf.net

