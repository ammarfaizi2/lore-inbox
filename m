Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316549AbSEUH7X>; Tue, 21 May 2002 03:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316547AbSEUH7W>; Tue, 21 May 2002 03:59:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14535 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316542AbSEUH7W>;
	Tue, 21 May 2002 03:59:22 -0400
Date: Tue, 21 May 2002 00:45:24 -0700 (PDT)
Message-Id: <20020521.004524.34353384.davem@redhat.com>
To: ccaputo@alt.net
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org
Subject: Re: [PATCH] net/core/sock.c - 2.4.18
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205201738180.19839-100000@nacho.alt.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Caputo <ccaputo@alt.net>
   Date: Mon, 20 May 2002 17:44:10 -0700 (PDT)

   This patch corrects a typo in net/core/sock.c.  The assignment to
   sysctl_wmem_default was done twice in a row, rather than to
   sysctl_wmem_default and sysctl_rmem_default.
   
   This patch applies to 2.4.18.
   
Thanks, I've applied your patch.
