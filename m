Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310953AbSDITR6>; Tue, 9 Apr 2002 15:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310979AbSDITR5>; Tue, 9 Apr 2002 15:17:57 -0400
Received: from dsl3-63-249-88-76.cruzio.com ([63.249.88.76]:17578 "EHLO
	athlon.cichlid.com") by vger.kernel.org with ESMTP
	id <S310953AbSDITR4>; Tue, 9 Apr 2002 15:17:56 -0400
Date: Tue, 9 Apr 2002 12:17:51 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200204091917.g39JHpe15914@athlon.cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Tyan S2462 reboot problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> what (which config option) could be the reason for a reboot hang on a
>S2462 (2x1900MP, 2GB, BIOS 2.09) between POST/BIOS and LILO?

You don't say what kind of disk controllers but 2.4.18 was broken with
respect to error handling and Promise IDE controllers. I have one flakey disk
that would reboot a new machine after a few minutes activity. 2.4.19pre6 just
prints an error message, retrys and gos merrily on it way.

So if you have Promise chips maybe try switching boot drives?

HTH

Andrew Burgess

