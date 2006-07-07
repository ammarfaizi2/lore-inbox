Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWGGTDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWGGTDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWGGTDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:03:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51929 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750800AbWGGTDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:03:37 -0400
Subject: Re: more rc1 lockdep fun.
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <20060707185848.GA5818@redhat.com>
References: <20060707185848.GA5818@redhat.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 21:03:35 +0200
Message-Id: <1152299015.3111.138.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 14:58 -0400, Dave Jones wrote:
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> -------------------------------------------------------
> gnome-settings-/3278 is trying to acquire lock:
>  (sk_lock-AF_INET){--..}, at: [<ffffffff8022800c>] tcp_sendmsg+0x1f/0xb1a


this appears to be the same one as the "mc" one I just looked at.


