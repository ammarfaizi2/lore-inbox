Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVGVXQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVGVXQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 19:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVGVXQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 19:16:27 -0400
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:56676 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262216AbVGVXQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 19:16:26 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: fix suspend/resume irq request free for yenta..
Date: Fri, 22 Jul 2005 18:16:17 -0500
User-Agent: KMail/1.8.1
Cc: Dave Airlie <airlied@linux.ie>
References: <Pine.LNX.4.58.0507222331580.15287@skynet>
In-Reply-To: <Pine.LNX.4.58.0507222331580.15287@skynet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507221816.19424.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 July 2005 17:33, Dave Airlie wrote:
> 
> Without this patch my laptop fails to resume from suspend to RAM...
> 
> It applies against a pretty recent 2.6.13-rc3 from git..
> 

Hi,

Is it necessary to do free_irq for suspend? Shouldn't disable_irq
be enough?

-- 
Dmitry
