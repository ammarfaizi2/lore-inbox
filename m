Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUDUWei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUDUWei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 18:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUDUWei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 18:34:38 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:23894 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262398AbUDUWeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 18:34:37 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "E.Rodichev" <er@sai.msu.su>
Subject: Re: [PATCH] Direct /dev/psaux driver and relevant Kconfig changes
Date: Wed, 21 Apr 2004 17:27:04 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.58.0404212031450.2778@ra.sai.msu.su>
In-Reply-To: <Pine.GSO.4.58.0404212031450.2778@ra.sai.msu.su>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404211727.05491.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 April 2004 11:32 am, E.Rodichev wrote:
> 
> This patch incorporates:
> 
> - direct /dev/psaux driver  written by Lee Sau Dan nad fixed by
>   Tuukka Toivonen;
> - drivers/input/Kconfig patch by Dmitry Torokhov (which allows
>   disabling legacy psaux device)
> - appropriate changes for help section for CONFIG_INPUT_PSAUX
> 
> Touchpad at my IBM A21m ThinkPad works fine with tp4d daemon -
> kernel 2.6.5 whith this patch applyed, either with driver compiled
> as a module or directly.
> 

The driver is not ready for kernel proper - it will not work for machines
with active multiplexing controllers (4 AUX + KBD port) and these are quite
common.

-- 
Dmitry
