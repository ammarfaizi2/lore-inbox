Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264552AbTDPSUx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTDPSUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:20:53 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:17898 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264552AbTDPSUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:20:50 -0400
Subject: Re: RedHat 9 and 2.5.x support
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030416165408.GD30098@wind.cocodriloo.com>
References: <20030416165408.GD30098@wind.cocodriloo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050517953.598.16.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 16 Apr 2003 20:32:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 18:54, Antonio Vargas wrote:
> I've just installed RedHat 9 on my desktop machine and I'd like
> if it will support running under 2.5.65+ instead of his usual
> 2.4.19+.

I'm running on RHL 9 with 2.5.67-mm3 (plus Russell King PCMCIA/CardBus
patches) and updated modutils + procutils + nfs-utils. It works
flawlessly, although I needed some tweaking for "/etc/init.d/rc.sysinit"
which insists in setting the module and hotplug helper binaries to
"/sbin/true" due to missing "/proc/ksyms".
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

