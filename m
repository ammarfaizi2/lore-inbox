Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263299AbSJCNbD>; Thu, 3 Oct 2002 09:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbSJCNbD>; Thu, 3 Oct 2002 09:31:03 -0400
Received: from web9605.mail.yahoo.com ([216.136.129.184]:39717 "HELO
	web9605.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263299AbSJCNbC>; Thu, 3 Oct 2002 09:31:02 -0400
Message-ID: <20021003133634.9670.qmail@web9605.mail.yahoo.com>
Date: Thu, 3 Oct 2002 06:36:34 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] 2.5.40 - remove IPV6_ADDRFORM
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021003.054332.22032944.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Are we absolutely sure no applications use this?

Xinetd uses it, which is what kicked off the original
discussion 2 days ago. Inetd applications are probably
the only applications that need this so they can
downgrade a socket for an old app. If its deprecated
and not on other platforms, I'm going to need to
change xinetd anyways. Sus v3 does not mention
IPV6_ADDRFORM at all. 

>Also, if you are going to fix the indentation in 
>the header file, please do so in a seperate patch.

Hmmm, I only wanted to renumber the options since #1
was removed. Sorry if it changed the alignment.

Cheers,
-Steve Grubb

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
