Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131145AbQK3UGL>; Thu, 30 Nov 2000 15:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131148AbQK3UGB>; Thu, 30 Nov 2000 15:06:01 -0500
Received: from 4dyn129.com21.casema.net ([212.64.95.129]:38925 "HELO
        home.ds9a.nl") by vger.kernel.org with SMTP id <S131149AbQK3Tvc>;
        Thu, 30 Nov 2000 14:51:32 -0500
Date: Thu, 30 Nov 2000 20:20:43 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Cc: aeb@cwi.nl
Subject: SO_RCVTIMEO and SO_SNDTIMEO implemented? manpage says no, kernel yes?
Message-ID: <20001130202042.A19106@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org, aeb@cwi.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was reading the works of Stevens, and saw the very neat SO_RCVTIMEO and
SO_SNDTIMEO features mentioned. Socket.7 told me that these socket
options aren't implemented:

       SO_RCVTIMEO and SO_SNDTIMEO
              Specify the sending  or  receiving  timeouts  until
              reporting  an  error.  They are fixed to a protocol
              specific setting in Linux and  cannot  be  read  or
              written.  Their functionality can be emulated using
              alarm(2) or setitimer(2).

However, reading 2.4.0test10 net/core/sock.c appears to indicate that the
kernel at least does some of the work. Does anybody know if these socket
options work as they should under Linux, and if so, which versions?

I might even whip up a better entry for the manpage if given enough data.

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
