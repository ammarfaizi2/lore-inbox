Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269758AbSISCF1>; Wed, 18 Sep 2002 22:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269759AbSISCF1>; Wed, 18 Sep 2002 22:05:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14223 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269758AbSISCF0>;
	Wed, 18 Sep 2002 22:05:26 -0400
Date: Wed, 18 Sep 2002 19:01:17 -0700 (PDT)
Message-Id: <20020918.190117.53168129.davem@redhat.com>
To: greearb@candelatech.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Networking: send-to-self [link to non-broken patch
 this time]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D893165.10106@candelatech.com>
References: <3D890A51.7000103@candelatech.com>
	<20020918.182855.47438220.davem@redhat.com>
	<3D893165.10106@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Wed, 18 Sep 2002 19:07:33 -0700

   David S. Miller wrote:
   
   > I mean put the ifdefs in a header file such as tcp.h, not in the *.c
   > code.
   
   Would you object to me just removing all of them and having the patch
   unconditionally compiled in?

Your comments say that SIOCBINDTODEVICE behavior is changed, how can
we legitimately do that all the time without breaking apps?
