Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVF1VXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVF1VXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVF1VXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:23:14 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:38412 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261327AbVF1VVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:21:42 -0400
Date: Tue, 28 Jun 2005 23:21:57 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: akpm@osdl.org, video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1]  V4L CX88 patch - against 2.6.12-mm2
Message-Id: <20050628232157.214c76fd.khali@linux-fr.org>
In-Reply-To: <42C19F6A.6020501@brturbo.com.br>
References: <42C19F6A.6020501@brturbo.com.br>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Your patch adds trailing whitespace in various places:

> -		core->tuner_type, core->tuner_addr<<1,
> +		core->tuner_type, core->tuner_addr<<1, 

> -		ir->mask_keycode = 0x8f8;
> +		ir->mask_keycode = 0x8f8; 

> -		ir->mask_keycode = 0x1f;
> +		ir->mask_keycode = 0x1f; 

> -static int or51132_set_ts_param(struct dvb_frontend* fe,
> +static int or51132_set_ts_param(struct dvb_frontend* fe, 

Six people signing this patch and nobody noticed? Amazing.

Please fix, thanks.

-- 
Jean Delvare
