Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274496AbRITNxr>; Thu, 20 Sep 2001 09:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274498AbRITNxh>; Thu, 20 Sep 2001 09:53:37 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:774 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S274496AbRITNxa>; Thu, 20 Sep 2001 09:53:30 -0400
Subject: Re: Error compiling 2.4.9 as bzImage
From: Richard Russon <ntfs@flatcap.org>
To: android@abac.com
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <01092003271500.00371@cy60022-a>
In-Reply-To: <01092003271500.00371@cy60022-a>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 14:52:28 +0100
Message-Id: <1000993948.7541.38.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Android,

> The following errors occured while trying to compile kernel 2.4.9:
> ...

This is a known problem.  Simply add the following line to unistr.c

  #include <linux/kernel.h>

Cheers,
    FlatCap (Rich).
    ntfs@flatcap.org



