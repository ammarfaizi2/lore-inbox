Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbUKUXrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbUKUXrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbUKUXrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:47:09 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:39074 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261869AbUKUXqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:46:21 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: help: sysrq and X
Date: Sun, 21 Nov 2004 18:46:17 -0500
User-Agent: KMail/1.6.2
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>
References: <41A122E0.8070307@eyal.emu.id.au>
In-Reply-To: <41A122E0.8070307@eyal.emu.id.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411211846.17628.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 November 2004 06:21 pm, Eyal Lebedinsky wrote:
> I am trying to diagnose a hard lockup. The only way I can reproduce it is
> with mythtv. When the system locks up (no mouse, no activity in X, no message
> logged) I can use magic sysrq, but I cannot see the output.
> 
> Using 'r' does not enable console switching. However 'b' will boot the
> system, and I hope 's' and 'u' did something blindly.
> 
> I there a way to regain a text console in order to inspect the kernel?
> 

Try use SysRQ+K (SAK) - 95% when my X server locks up I can use SAK and then
killall -9 X and everythig is fine.  

-- 
Dmitry
