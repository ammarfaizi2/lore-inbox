Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263308AbSJCMpP>; Thu, 3 Oct 2002 08:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263309AbSJCMpP>; Thu, 3 Oct 2002 08:45:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51153 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263308AbSJCMpO>;
	Thu, 3 Oct 2002 08:45:14 -0400
Date: Thu, 03 Oct 2002 05:43:32 -0700 (PDT)
Message-Id: <20021003.054332.22032944.davem@redhat.com>
To: linux_4ever@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.40 - remove IPV6_ADDRFORM
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021003124509.83822.qmail@web9608.mail.yahoo.com>
References: <20021003124509.83822.qmail@web9608.mail.yahoo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steve G <linux_4ever@yahoo.com>
   Date: Thu, 3 Oct 2002 05:45:09 -0700 (PDT)

   The following patch removes the deprecated
   IPV6_ADDRFORM socket option from 2.5.40. I checked
   OpenBSD & FreeBSD and both do not support this option,
   so I think its safe to remove.

Are we absolutely sure no applications use this?

Also, if you are going to fix the indentation in the header
file, please do so in a seperate patch.  Thanks.
