Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbRGXPAf>; Tue, 24 Jul 2001 11:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267556AbRGXPA0>; Tue, 24 Jul 2001 11:00:26 -0400
Received: from [62.225.179.11] ([62.225.179.11]:48912 "EHLO mail.degrp.org")
	by vger.kernel.org with ESMTP id <S267550AbRGXPAK>;
	Tue, 24 Jul 2001 11:00:10 -0400
Message-ID: <9DD550E9A9B0D411A16700D0B7E38BA4515130@POL-EML-SRV1>
From: "Antwerpen, Oliver" <Antwerpen@netsquare.org>
To: linux-kernel@vger.kernel.org
Subject: udp-broadcast
Date: Tue, 24 Jul 2001 17:00:45 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Moin!

I don't know if this is the right place to ask, so I'll ask:

I try to send udp to my networks broadcast-address. All I get is a
"permission denied", so I tried to use setsockopt, but that doesn't work
either. It gives my a "protocol not available".

What do I have to do to send my package?

--snip--

  ret = setsockopt(my_socket, IPPROTO_UDP, SO_BROADCAST, (void *)&flag,
sizeof(flag) );


  ret = sendto(
                  my_socket,
                  wake_msg,
                  strlen(wake_msg),
                  0,
                  (struct sockaddr *)&dst_address,
                  sizeof(struct sockaddr)
                  );


--snip--

Olli

please cc: me when answering...
