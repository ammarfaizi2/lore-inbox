Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313969AbSDKCvX>; Wed, 10 Apr 2002 22:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313970AbSDKCvW>; Wed, 10 Apr 2002 22:51:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1488 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313969AbSDKCvW>;
	Wed, 10 Apr 2002 22:51:22 -0400
Date: Wed, 10 Apr 2002 19:44:11 -0700 (PDT)
Message-Id: <20020410.194411.48882878.davem@redhat.com>
To: mfedyk@matchmail.com
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com, akpm@zip.com.au,
        buytenh@gnu.org
Subject: Re: [BUG] DEADLOCK when removing a bridge on 2.4.19-pre6
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020411014035.GJ23513@matchmail.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mike Fedyk <mfedyk@matchmail.com>
   Date: Wed, 10 Apr 2002 18:40:35 -0700

   On Wed, Apr 10, 2002 at 06:05:15PM -0700, Mike Fedyk wrote:
   > 2.4.19-pre6-nobr0fpsh building now...
   
   Yep, reversing 2.4.18_fix_port_state_handling.diff fixed it.

Thanks for tracking this down so precisely.  If every bug reporter
actually bothered to do this work, it'd take a lot less work to
fix most bugs :-)

Lennert, just let me know when you have a fix :-)
