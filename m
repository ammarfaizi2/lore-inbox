Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130606AbRCPQDl>; Fri, 16 Mar 2001 11:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130733AbRCPQDc>; Fri, 16 Mar 2001 11:03:32 -0500
Received: from ns2.cypress.com ([157.95.67.5]:31954 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S130606AbRCPQDX>;
	Fri, 16 Mar 2001 11:03:23 -0500
Message-ID: <3AB23913.E1AF0023@cypress.com>
Date: Fri, 16 Mar 2001 10:02:27 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Wayne.Brown@altec.com
Subject: Re: How to mount /proc/sys/fs/binfmt_misc ?
In-Reply-To: <86256A11.005489D0.00@smtpnotes.altec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne.Brown@altec.com wrote:
> 
> 
> which makes sense, I guess, because proc isn't a "real" filesystem.  So how do I
> get binfmt_misc mounted?

mount it somewhere else, say, /dev/binfmt_mount instead of in /proc
until the proc entry is fixed. What should creat
/proc/sys/fs/binfmt_misc ?

	-Thomas
