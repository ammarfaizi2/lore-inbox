Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312895AbSDJMBE>; Wed, 10 Apr 2002 08:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312888AbSDJMBD>; Wed, 10 Apr 2002 08:01:03 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:12500 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S312895AbSDJMBC>; Wed, 10 Apr 2002 08:01:02 -0400
From: <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Horton <pdh@berserk.demon.co.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radeon frame buffer driver
Date: Wed, 10 Apr 2002 14:01:05 +0100
Message-Id: <20020410130106.1191@mailhost.mipsys.com>
In-Reply-To: <Pine.GSO.4.21.0204101305210.24941-100000@trillium.sonytel.be>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The colour map is only used by the kernel and the kernel only uses 16
>> entries so there isn't any reason to waste memory by making it any
>> larger. I checked a few other drivers and they do the same (aty128fb for
>> one).
>
>However, this change will make the driver not save/restore all color map
>entries on VC switch in graphics mode.

Geert, didn't you tell me the fbdev apps were responsible for restoring
their cmap on console switch ?

Ben.



