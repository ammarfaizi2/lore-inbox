Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312420AbSDXRJV>; Wed, 24 Apr 2002 13:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312426AbSDXRJU>; Wed, 24 Apr 2002 13:09:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48004 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312420AbSDXRJU>;
	Wed, 24 Apr 2002 13:09:20 -0400
Date: Wed, 24 Apr 2002 09:59:51 -0700 (PDT)
Message-Id: <20020424.095951.43413800.davem@redhat.com>
To: jd@epcnet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <721506265.avixxmail@nexxnet.epcnet.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jd@epcnet.de
   Date: Wed, 24 Apr 2002 19:03:19 +0200

   Oh. Even in 2.4 ?

Yes, the "cannot do VLAN" flag is there in 2.4.x
    
   That's a good idea. So vconfig could check, if its possible to
   create a VLAN on top of such a driver - and issue a message if
   not.
   
VLAN layer checks this and fails to bring up VLAN if
flag is set for the device being configured.  I'm way
ahead of you.

Franks a lot,
David S. Miller
davem@redhat.com
