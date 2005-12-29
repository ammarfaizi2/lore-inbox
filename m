Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbVL2AGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVL2AGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVL2AGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:06:12 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:5835 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932558AbVL2AGL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:06:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E5iixeuY5HPqGxB2WdQQ6AXJ9QpIOqvZ31MEL7deN8Ch4KK7h1HOzG1bb6aH7Sge1GNtAs0gOaj59CcR1vbT6fXOMs4xv+eLB/OyhjWfZi/+LS+TlRTSkpTCPj8abx7/xSeaHQpp7+7B8iZjJFT/UjxVyWcgjP5xFfcIrojvwg0=
Message-ID: <9611fa230512281606y4ae3e163u43742b5146c71161@mail.gmail.com>
Date: Thu, 29 Dec 2005 00:06:10 +0000
From: Tarkan Erimer <tarkane@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG]: Hard lockups continue with linux-2.6.15-rc1-rc7
Cc: sboyce@blueyonder.co.uk
In-Reply-To: <43B06063.8030909@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43B06063.8030909@blueyonder.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sid,

On 12/26/05, Sid Boyce <sboyce@blueyonder.co.uk> wrote:
> Don't rule out hardware. This SuSE 10.0 x86 box worked without problems
> on kernels up to 2.6.15-rc6-git2, but I experienced strange apparent
> filesystem corruptions/compile failures running normally and hard
> lockups when running mythtv with 2.6.15-rc6-git6 and 2.6.15-rc7, while
> on the Mandriva 2006 x86 box and the SuSE x86_64 there were no problems.
> Until I found the suspect SDRAM, on some occasions I had to run
> reiserfsck before 2.6.15-rc6-git2 would boot again correctly after
> trying rc6-git6 or -rc7. Finally I got a corruption again with
> 2.6.15-rc7, replaced the SDRAM stick with the one taken out previously,
> booted up on 2.6.15-rc7 with no problems. I had run memtest some days
> earlier, but only for a couple of hours. (current uptime 1 day 1.04hrs).

Hmmm.. It looks, it is time to run memtest on my box. Thanks for the tip.

Regards,
