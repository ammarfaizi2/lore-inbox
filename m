Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263697AbUEPRSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUEPRSm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUEPRSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:18:42 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:55183 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263697AbUEPRSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:18:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] Synaptics driver is 'jumpy'
Date: Sun, 16 May 2004 12:18:37 -0500
User-Agent: KMail/1.6.2
Cc: Jan De Luyck <lkml@kcore.org>
References: <200405161222.48581.lkml@kcore.org>
In-Reply-To: <200405161222.48581.lkml@kcore.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405161218.37521.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 May 2004 05:22 am, Jan De Luyck wrote:
> Hello List,
> 
> Since installing 2.6.6 on my trusty laptop, I can't use the built-in synaptics
> touchpad anymore. The tracking is totally broken:
> 
> When you touch-drag on the touchpad, the mouse cursor will jump to where you
> stopped your action approx. 1/1.5 seconds _after_ your move. This makes using
> the touchpad virtually impossible.
> 
> This problem is not present under 2.6.5, which I'm running right now.
> Same .config.
> 
> Nothing seems to show up in the logs that could reflect any problem.
> 

Hmm.. there was no changes to PS/2 processing between 2.6.5 and 2.6.6 except
for some Logitech tweaking, but it should not affect Synaptics handling in
any way...

Could you check if you still have DMA enabled on your disks, check your time
source (TSC, ACPI PM timer, etc) and probably boot with acpi off?

Thank you.

-- 
Dmitry
