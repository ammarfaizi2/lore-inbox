Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282168AbRK1Xan>; Wed, 28 Nov 2001 18:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282176AbRK1Xaf>; Wed, 28 Nov 2001 18:30:35 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:33040 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282168AbRK1XaU>; Wed, 28 Nov 2001 18:30:20 -0500
Message-ID: <3C057358.95C181A5@zip.com.au>
Date: Wed, 28 Nov 2001 15:29:28 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David C. Hansen" <haveblue@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
In-Reply-To: <200111282305.fASN5ap02626@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David C. Hansen" wrote:
> 
> +static spinlock_t              user_list_lock;

	= SPIN_LOCK_UNLOCKED;
