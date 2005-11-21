Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVKUBNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVKUBNw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVKUBNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:13:52 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:3469 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932157AbVKUBNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:13:51 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Zorglub <zorglub_olsen@hotmail.com>
Subject: Re: Oops on 2.6.14
Date: Mon, 21 Nov 2005 12:13:45 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200511202326.16222.zorglub_olsen@hotmail.com>
In-Reply-To: <200511202326.16222.zorglub_olsen@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511211213.45798.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005 09:26, Zorglub wrote:
> Hi list,
>
> my machine suddenly froze. It's been working just fine for about a week or
> so. No unusual load. I read in Documentation/oops-tracing.txt that I should
> probably send the log (var/log/messages) to this list. So here goes:

Thank you for your bug report.

> Nov 20 23:07:52 asimov Modules linked in: nvidia
> Nov 20 23:07:52 asimov EIP:    0060:[<c0114096>]    Tainted: P      VLI

Unfortunately we can only provide support for code we wrote and have access 
to. The nvidia and other proprietary binary only drivers cause bugs that we 
are unable to debug. Please try to reproduce the problem without any binary 
only drivers.

Regards,
Con
