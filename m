Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270519AbUJTXnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270519AbUJTXnJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270335AbUJTXab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:30:31 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:49523 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270557AbUJTXQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:16:11 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=lGz1CFzlZUqSa0jKIRN95ZbPm451GyZzMWuKzAhxxGIE3lEqdF5uiEC5D6FcMsP3iaB6X93nYMFO6QyVFfKAcUQN9TTnLb3oywDn5hi0q2zOtfRRbKwkOtNs5LqPILukpug/aF60Wr+wFC3TgA28/jCv2g2d2KRCouGB7WIX9UE
Message-ID: <b476569a0410201616415b0600@mail.gmail.com>
Date: Wed, 20 Oct 2004 11:16:05 -1200
From: Adam Hunt <kinema@gmail.com>
Reply-To: Adam Hunt <kinema@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: I/O scheduler recomendation for Linux as a VMware guest
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am forced to spend quite a bit of time with my only relatively
powerful workstation booted into XP so I can do CAD work
(unfortunately Autodesk's Inventor only runs on Windows).  Because of
this unfortunate situation I am planning my first attempt to get the
Linux install that I have on the other drive in this workstation to
boot using VMware.  VMware has the ability to access raw disk
partitions (as apposed to partitions stored in a file on a host
partition) so I figure with some init and /etc magic I should be able
to boot the system using VMware and when I am not drawing in Inventor
I should be able to reboot and run Linux natively directly on the
hardware.

What I am wondering is what I/O scheduler should I be using when the
system is running within a VMware instance?  I figure that Windows
will be scheduling the access to the physical hardware so I would
assume that I want a bare bones priority based scheduler, something
with the lowest possible overhead.  Is this correct?  If so, what
would that scheduler be?

IIRC someone (Ingo?) was working on the ability to change schedules
during runtime.  How has that work progressed?  Is it available in any
kernel trees?

--adam
