Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUDZOIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUDZOIr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 10:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbUDZOHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 10:07:51 -0400
Received: from main.gmane.org ([80.91.224.249]:22419 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263851AbUDZOFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 10:05:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: [PATCH 2/9] DVB: Documentation and Kconfig updazes
Date: Mon, 26 Apr 2004 16:05:46 +0200
Message-ID: <yw1x4qr6ltqd.fsf@kth.se>
References: <10829866821854@convergence.de> <10829867363017@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:vUK/+RPQXAe+mCBaLUe6AfiLUJo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold <hunold@linuxtv.org> writes:

> diff -urawBN xx-linux-2.6.5/drivers/media/dvb/Kconfig linux-2.6.5-patched/drivers/media/dvb/Kconfig
> --- xx-linux-2.6.5/drivers/media/dvb/Kconfig	2004-03-12 20:31:28.000000000 +0100
> +++ linux-2.6.5-patched/drivers/media/dvb/Kconfig	2003-10-13 06:08:45.000000000 +0200
> @@ -18,12 +18,11 @@
>  	  Please report problems regarding this driver to the LinuxDVB 
>  	  mailing list.
>
> -	  You might want add the following lines to your /etc/modprobe.conf:
> +	  You might want add the following lines to your /etc/modules.conf:
>
>  	  	alias char-major-250 dvb
>  	  	alias dvb dvb-ttpci
> -	  	install dvb-ttpci /sbin/modprobe --first-time -i dvb-ttpci && \
> -			/sbin/modprobe -a alps_bsru6 alps_bsrv2 \
> +	  	below dvb-ttpci alps_bsru6 alps_bsrv2 \
>  	  			grundig_29504-401 grundig_29504-491 \
>  	  			ves1820

This looks wrong for a 2.6 kernel.

-- 
Måns Rullgård
mru@kth.se

