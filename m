Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbTBADTu>; Fri, 31 Jan 2003 22:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTBADTu>; Fri, 31 Jan 2003 22:19:50 -0500
Received: from relay01.valueweb.net ([216.219.253.235]:20205 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S264705AbTBADTu>; Fri, 31 Jan 2003 22:19:50 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: Perl in the toolchain
Date: Fri, 31 Jan 2003 22:28:57 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJCEEJEIAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33D78@EXCHANGE>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Write a perl interpreter in Python!
> of course, to avoid merely moving the problem, Python then would be
> implemented in a bash script ...

Or we could just use Parrot, and be done with it!

Seriously: While Perl's faults may be in the eyes of its beholders, the real
point here is complicating the build environment for the kernel.

As a fundamental piece of portable software, the kernel should build in a
minimal environment. Perl may indeed be a good choice for text munging --
but it is not the only choice, and using it adds yet another requirement to
the kernel build environment.

Minimizing the build environment simple is a valid requirement for selecting
a tool.

..Scott

--
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Professional programming for science and engineering;
Interesting and unusual bits of very free code.

