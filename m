Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131400AbRCPVs4>; Fri, 16 Mar 2001 16:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131409AbRCPVss>; Fri, 16 Mar 2001 16:48:48 -0500
Received: from imr1.ericy.com ([208.237.135.240]:6140 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id <S131400AbRCPVsm>;
	Fri, 16 Mar 2001 16:48:42 -0500
Message-ID: <7E67DE81C0B6D311B30500805FFEBAAE03078E40@lmc35.lmc.ericsson.se>
From: "Mathieu Giguere (LMC)" <lmcmgig@lmc.ericsson.se>
To: "'David S. Miller'" <davem@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Claude LeFrancois (LMC)" <lmcclef@lmc.ericsson.se>
Subject: RE: UDP stop transmitting packets!!!
Date: Fri, 16 Mar 2001 16:47:57 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your answer.
We will have a patch internally to handle this protection.

/mathieu

> -----Original Message-----
> From:	David S. Miller [SMTP:davem@redhat.com]
> Sent:	Friday, March 16, 2001 4:46 PM
> To:	Mathieu Giguere (LMC)
> Cc:	'linux-kernel@vger.kernel.org'; Claude LeFrancois (LMC)
> Subject:	RE: UDP stop transmitting packets!!!
> 
> 
> Mathieu Giguere (LMC) writes:
>  > Ok fine to live with that for security reason, but the socket will be
> dead
>  > for ever! (the only way to remove it is to reboot the machine)
> 
> If you kill the application, the queue is emptied and tossed
> by the kernel.
> 
> Later,
> David S. Miller
> davem@redhat.com
