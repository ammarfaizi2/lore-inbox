Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131791AbQLVDlO>; Thu, 21 Dec 2000 22:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131819AbQLVDlE>; Thu, 21 Dec 2000 22:41:04 -0500
Received: from [204.244.205.25] ([204.244.205.25]:10088 "HELO post.gateone.com")
	by vger.kernel.org with SMTP id <S131791AbQLVDlA>;
	Thu, 21 Dec 2000 22:41:00 -0500
From: Michael Peddemors <michael@linuxmagic.com>
Organization: Wizard Internet Services
To: "David S. Miller" <davem@redhat.com>, kernel@pineview.net
Subject: Re: No more DoS
Date: Thu, 21 Dec 2000 20:20:06 -0800
X-Mailer: KMail [version 1.1.95.0]
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <977453684.3a42c2744fbb7@ppro.pineview.net> <200012220200.SAA05057@pizda.ninka.net>
In-Reply-To: <200012220200.SAA05057@pizda.ninka.net>
MIME-Version: 1.0
Message-Id: <0012212020061G.24471@mistress>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Furthermore, it also cannot work because it makes retransmissions
> of the SYN/ACK very non-workable.  I suppose his TCP stack just hacks
> around this by just waiting for the original client SYN to get
> retransmitted or something like this.  I question whether that can
> even work reliably.

Be interesting to see his response, but in truth, do we care if it gets 
retransmitted?? When it does, it does...

> I think not holding onto any state for an incoming SYN is nothing but
> a dream in any serious modern TCP implementation.  It can be reduced,
> but not eliminated.  The former is what most modern stacks have done
> to fight these problems.

A dream, maybe .... but hey so were most things that we now take for granted..
Worth kicking around a bit tho...  

--------------------------------------------------------
Michael Peddemors - Senior Consultant
Unix Administration - WebSite Hosting
Network Services - Programming
Wizard Internet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604) 589-0037 Beautiful British Columbia, Canada
--------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
