Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132629AbRDGLAq>; Sat, 7 Apr 2001 07:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132628AbRDGLA1>; Sat, 7 Apr 2001 07:00:27 -0400
Received: from colorfullife.com ([216.156.138.34]:54027 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132627AbRDGLAV>;
	Sat, 7 Apr 2001 07:00:21 -0400
Message-ID: <3ACEF337.F3300093@colorfullife.com>
Date: Sat, 07 Apr 2001 13:00:07 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac20 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: armin@xos.net
CC: linux-kernel@vger.kernel.org
Subject: Re: linux 2.2.19 smp interrupt problems?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> everything seems to work fine. are these interrupt problems "bad" or merely 
> indicators of a high load. can/should one get rid of them? 
>
Could you try the 8139too driver?

It's a bug in the rtl8139 driver, and under really high load it can
cause crashes.

--
	Manfred
