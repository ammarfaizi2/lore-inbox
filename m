Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752167AbWCOXdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbWCOXdq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbWCOXdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:33:46 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:62114 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751295AbWCOXdo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:33:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WQ2pg0oCSRWzQvNLGSazR1XDQ/BtvO27U+/q729Zj+MI4PWAT4X7S8Q6RUGgovTr7OH6fYIDCEXeqsuEXkb+QV86IgSfr313Z2ZTBTYled1fsF8+lfI+fPzD2iyzpylHoroOcwCDiVZxkJgPseJa0H6mc778711h7xmPShw27eo=
Message-ID: <4807377b0603151533i6a693d99ycdab71fe0a21dc4c@mail.gmail.com>
Date: Wed, 15 Mar 2006 15:33:43 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH]: e1000 endianness bugs
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org,
       cramerj@intel.com, john.ronciak@intel.com,
       "Jesse Brandeburg" <jesse.brandeburg@intel.com>
In-Reply-To: <20060315.142628.28661597.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060315.142628.28661597.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/06, David S. Miller <davem@davemloft.net> wrote:
>
>         return -E_NO_BIG_ENDIAN_TESTING;
>
> [E1000]: Fix 4 missed endianness conversions on RX descriptor fields.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>

Yep, those look like bugs to me, thanks and congratulations, you're
the first person to test our PCI Express adapters in a big endian
system (they haven't been available before, and we don't have one,
yet)

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
