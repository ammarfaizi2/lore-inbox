Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130940AbRC0JIT>; Tue, 27 Mar 2001 04:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131020AbRC0JIJ>; Tue, 27 Mar 2001 04:08:09 -0500
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:62509 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S130940AbRC0JHs>; Tue, 27 Mar 2001 04:07:48 -0500
Message-ID: <3AC05833.96A3127E@stud.uni-saarland.de>
Date: Tue, 27 Mar 2001 09:06:59 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: puckwork@madz.net
CC: linux-kernel@vger.kernel.org
Subject: Re: URGENT : System hands on "Freeing unused kernel memory: "
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 2 ideas:
* glibc corrupted
* did you downgrade the cpu?

RH 7.0 automatically installs glibc for a Pentium Pro or later if that
cpu is present during install.
If you then move the hd into a computer with an AMD K6, it won't boot.

I'd run

#rpm -Va

and check if some unusual files are modified (...5.. without "c")

--
	Manfred
