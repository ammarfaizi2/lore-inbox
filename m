Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVATDpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVATDpe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVATDpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:45:34 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:43667 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262024AbVATDpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:45:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: segfault@club-internet.fr
Subject: Re: [PATCH] Alps touchpad probing failure
Date: Wed, 19 Jan 2005 22:45:28 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200501200024.01963.segfault@club-internet.fr>
In-Reply-To: <200501200024.01963.segfault@club-internet.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501192245.28544.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 January 2005 18:23, Daniel Caujolle-Bert wrote:
> Hi,
> 
>  With 2.6.11-rc1 bk6 and bk7 (didn't tried with < bk6), my alps touchpad is no 
> more correctly probed, it's recognised as a standard PS/2 mouse.
>  So, with this trivial two line patch, everything is working again.
> 
> Cheers.

Hi,

I think Peter Osterlund has send similar patch recently - the breakage
appears to be caused by Kensington mouse detection. It looks like these
two don't like each other.

-- 
Dmitry
