Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269910AbUJGXGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269910AbUJGXGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269909AbUJGXAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:00:32 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:6549 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S269868AbUJGWry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:47:54 -0400
X-BrightmailFiltered: true
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'David S. Miller'" <davem@davemloft.net>,
       "'Martijn Sipkema'" <msipkema@sipkema-digital.com>
Cc: <cfriesen@nortelnetworks.com>, <jst1@email.com>,
       <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>,
       <davem@redhat.com>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Thu, 7 Oct 2004 15:46:23 -0700
Organization: Cisco Systems
Message-ID: <012001c4acbf$786766f0$b83147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20041007152400.17e8f475.davem@davemloft.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't believe this thread has lasted this long.

The reason is that you haven't just admitted very clearly that 
"Linux select isn't Posix compliant and it was a design decision 
not to do so for performance reasons". I think this kind of 
authorative answer would shut up many people. :-)

> I think people had cotton in their ears when I mentioned 
> that every single 2.4.x and 2.6.x existing system out there 
> has this behavior, therefore even if we changed the behavior 
> some way today people still need to handle this to work on 
> all existing Linux systems.

Unfortunately this isn't the best argument..

I think most people just hope Linux would follow the standard.
The old Linux threads weren't posix-compliant either for years,
and people still fixed (most of?) it in 2.6. By your argument
that would not have happened.

Hua

