Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSELDJC>; Sat, 11 May 2002 23:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315183AbSELDJB>; Sat, 11 May 2002 23:09:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7629 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315167AbSELDJA>;
	Sat, 11 May 2002 23:09:00 -0400
Date: Sat, 11 May 2002 19:56:34 -0700 (PDT)
Message-Id: <20020511.195634.31204998.davem@redhat.com>
To: ltd@cisco.com
Cc: jgarzik@mandrakesoft.com, chen_xiangping@emc.com,
        linux-kernel@vger.kernel.org
Subject: Re: Tcp/ip offload card driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20020511114358.03cd6ab0@mira-sjcm-3.cisco.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Lincoln Dale <ltd@cisco.com>
   Date: Sat, 11 May 2002 11:53:33 +1000

   for example, if TOE was supported in a driver (eg. /dev/toeN) which allowed 
   user-space to mmap() into RAM (either on the card or main memory which the 
   TOE card DMAs into/out-of).

This is a very old concept, see UNET.

But that is %100 outside the realm of the TCP on a card stuff.
You don't even need firmware to do UNET, you just export the
packet descriptor rings into userspace.  Like I said, it's a
"been there, done that" technology.

Franks a lot,
David S. Miller
davem@redhat.com
