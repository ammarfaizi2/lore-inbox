Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbTBATTh>; Sat, 1 Feb 2003 14:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbTBATTh>; Sat, 1 Feb 2003 14:19:37 -0500
Received: from [81.2.122.30] ([81.2.122.30]:25867 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264915AbTBATTg>;
	Sat, 1 Feb 2003 14:19:36 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302011929.h11JTMiC010227@darkstar.example.net>
Subject: Re: [RFC] Little endian Cramfs on big endian machines?
To: Jon_Burgess@eur.3com.com (Jon Burgess)
Date: Sat, 1 Feb 2003 19:29:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <80256CC0.0067A8CA.00@notesmta.eur.3com.com> from "Jon Burgess" at Feb 01, 2003 06:51:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At the moment the cramfs code in 2.4 & 2.5 uses the native machine
> endianness for the filesystem layout. I believe this behaviour has
> been considered a bug and that the code changed such that the
> filsystem is always little endian.

Maybe the native machine endianness is used for performace reasons -
that would make sense given the typical uses of cramfs.  Also, it is a
read-only filesystem, so a userland application could flip the
endianness if a filesystem needs to be used on a non-native endianness
machine.

I'm not necessarily saying that that it's not a bug, just suggesting
an explaination.

John.
