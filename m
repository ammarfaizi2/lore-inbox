Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266620AbUGKQAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266620AbUGKQAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 12:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266621AbUGKQAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 12:00:42 -0400
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:28809 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S266620AbUGKQAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 12:00:40 -0400
Date: Sun, 11 Jul 2004 18:00:40 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: suspend/resume success and failure report and questions
In-reply-to: <20040710083027.GB27827@gamma.logic.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Message-id: <200407111800.40401@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
References: <20040710083027.GB27827@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 10. Juli 2004 10:30 schrieben Sie:
> - general
> 	clock is completely wrong - where is a post-resume script (see below)

Same here. The kernelclock is restored after resuming, but not set to the rtc.

> - Is it possible to get S2R to the level of S2D without problems?

Not yet, I suppose. But "we" are working in this area.

> - is there a way to get things done BEFORE the suspend (this I managed via
>   the acpi script), but also AFTER the resume.

Don't know. With acpid or apmd this could work.

regards
Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

