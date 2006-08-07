Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWHGCSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWHGCSK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 22:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWHGCSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 22:18:10 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:5705 "EHLO
	asav14.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750795AbWHGCSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 22:18:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAMg+1kSBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc3-mm2
Date: Sun, 6 Aug 2006 22:18:05 -0400
User-Agent: KMail/1.9.3
Cc: Fabio Comolli <fabio.comolli@gmail.com>, linux-kernel@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <b637ec0b0608060848k22af58cbo6f13cee19498c2d2@mail.gmail.com> <20060806120901.ee600a36.akpm@osdl.org>
In-Reply-To: <20060806120901.ee600a36.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608062218.06380.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 August 2006 15:09, Andrew Morton wrote:
> -tycho kernel: input: PS/2 Mouse as /class/input/input1
> -tycho kernel: input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
> 
> That's not so good.
> 
> 
> Dmitry, do you have anything in there which might have caused that?
> 
> Perhaps hdaps-handle-errors-from-input_register_device.patch is triggering
> for some reason.

Hmm, I'd be more concerned with i8042-get-rid-of-polling-timer patch...
Anyway, can I have dmesg from boot with i8042.debug=1, please? Make sure
you have big log biffer.

-- 
Dmitry
