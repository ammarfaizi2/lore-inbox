Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTLUKmK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 05:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTLUKmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 05:42:10 -0500
Received: from main.gmane.org ([80.91.224.249]:45487 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262598AbTLUKmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 05:42:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Firewire/sbp2 troubles with Linux 2.6.0
Date: Sun, 21 Dec 2003 11:42:05 +0100
Message-ID: <yw1x4qvumozm.fsf@ford.guide>
References: <yw1x8yl66ecs.fsf@ford.guide> <20031221035348.GM6607@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:YI8FQJCuQvV9rBQTICxRaSxK/Vo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> writes:

> On Sun, Dec 21, 2003 at 04:26:11AM +0100, M?ns Rullg?rd wrote:
>> 
>> I'm having some trouble connecting a Firewire hard disk box to a
>> laptop running Linux 2.6.0.  The disk is correctly detected when
>> connected, and can be mounted.  The problems start when I try to read
>> large files from the disk.  It will start off reading at about 10
>> MB/s, which seems a bit slow for Firewire.  The disks I've used are
>> capable of much more.  That's not the real problem, though.  After a
>> little while, sometimes as little as 1 MB, sometimes after about 50
>> MB, the reading will stall and this message is printed in the kernel
>> log:
>> 
>> ieee1394: sbp2: aborting sbp2 command
>> 0x28 00 03 6f d2 f1 00 00 f8 00 
>
> Please try the code in the repo on linux1394.org. I've done a lot of
> work to sbp2 since my last sync with Linus.

No difference at all.  What I think is strange, is that small reads or
reading at a slow rate works perfectly.  Any further ideas?

-- 
Måns Rullgård
mru@kth.se

