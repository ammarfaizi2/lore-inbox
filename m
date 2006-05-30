Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWE3DtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWE3DtE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 23:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWE3DtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 23:49:03 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:51572 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751297AbWE3DtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 23:49:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] fix mem-leak in sidewinder driver
Date: Mon, 29 May 2006 23:49:00 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@ucw.cz>,
       Andrew Morton <akpm@osdl.org>
References: <200605070403.47763.jesper.juhl@gmail.com>
In-Reply-To: <200605070403.47763.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605292349.00476.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 May 2006 22:03, Jesper Juhl wrote:
> In sw_connect we leak 'buf' and 'idbuf' when we do not leave via one of 
> the fail* labels. This was spotted by the coverity checker.
> This patch fixes the memory leak.
> 

Applied, thank you Jesper.

-- 
Dmitry
