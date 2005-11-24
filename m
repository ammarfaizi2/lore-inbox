Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932668AbVKXX0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbVKXX0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 18:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVKXX0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 18:26:09 -0500
Received: from hermes.domdv.de ([193.102.202.1]:38930 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S932668AbVKXX0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 18:26:08 -0500
Message-ID: <43864C0F.1090403@domdv.de>
Date: Fri, 25 Nov 2005 00:26:07 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp resume from dm-crypt over lvm?
References: <20051124215806.GA8086@hardeman.nu>
In-Reply-To: <20051124215806.GA8086@hardeman.nu>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman wrote:
> Using the ability to echo the major:minor to /sys/power/resume from an
> initramfs script I am able to resume from a lvm partition.
> 
> However, this doesn't seem to work if the swap partition is encrypted
> and setup using cryptsetup (dm-crypt over an lvm partition that is).
> 
> Is this supposed to work or is it not feasible?

See Documentation/power/swsusp-dmcrypt.txt. Works for me.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
