Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVA2Wu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVA2Wu4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVA2Wu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:50:56 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:14772 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261579AbVA2Wuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:50:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
Date: Sat, 29 Jan 2005 17:50:50 -0500
User-Agent: KMail/1.7.2
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501292320090.7662@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501291750.50886.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 January 2005 17:20, Roman Zippel wrote:
> --- linux-2.6.11.orig/drivers/input/serio/Kconfig       2005-01-29 22:50:43.404946203 +0100
> +++ linux-2.6.11/drivers/input/serio/Kconfig    2005-01-29 22:56:42.549085439 +0100
> @@ -3,6 +3,7 @@
>  #
>  config SERIO
>         tristate "Serial i/o support" if EMBEDDED || !X86
> +       depends on INPUT

????

serio_raw works fine without INPUT.

-- 
Dmitry
