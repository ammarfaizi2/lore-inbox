Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293454AbSCFMMt>; Wed, 6 Mar 2002 07:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293507AbSCFMMj>; Wed, 6 Mar 2002 07:12:39 -0500
Received: from hera.cwi.nl ([192.16.191.8]:43656 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S293454AbSCFMMa>;
	Wed, 6 Mar 2002 07:12:30 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 6 Mar 2002 12:12:28 GMT
Message-Id: <UTC200203061212.MAA182963.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, dalecki@evision-ventures.com
Subject: Re: bitkeeper / IDE cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Plese note that the mail in wich I did send this particular patch
> didn't contain the cleanup term.

You forgot to check the Subject line.

> I would rather have a true lean *abstract* ioctl/sysctl
> based interface

I very much distrust the possibility of defining any abstract interface.
For special purpose things one just wants to send certain commands and
data to the disk, and user space knows which commands and what data,
and the kernel doesn't, so has to allow user space access.

Andries
