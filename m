Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUDPHkk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 03:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbUDPHkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 03:40:40 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:58774 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262625AbUDPHki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 03:40:38 -0400
Date: Fri, 16 Apr 2004 08:38:36 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andy Lutomirski <luto@stanford.edu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       shuchen@realtek.com.tw
Subject: Re: r8169 excessive PHY reset
Message-ID: <20040416083836.A24723@electric-eye.fr.zoreil.com>
References: <407F6CC8.1060903@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <407F6CC8.1060903@stanford.edu>; from luto@stanford.edu on Thu, Apr 15, 2004 at 10:19:04PM -0700
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@stanford.edu> :
[r8169 phy issue with 2.6.5-mm5]
> -	mod_timer(timer, RTL8169_PHY_TIMEOUT);

I forgot a 'jiffies +' there. It is fixed in current Linus's tree.

--
Ueimor
