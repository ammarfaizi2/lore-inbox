Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154534-8316>; Fri, 11 Sep 1998 18:21:31 -0400
Received: from mail.cyberus.ca ([209.195.95.1]:55562 "EHLO cyberus.ca" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154629-8316>; Fri, 11 Sep 1998 17:49:59 -0400
Date: Fri, 11 Sep 1998 20:39:46 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: linux-kernel@vger.rutgers.edu
Subject: Re: my broken TCP is faster on broken networks
Message-ID: <Pine.GSO.3.96.980911203117.13283B-100000@shell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


Theodore Y. Ts'o (tytso@MIT.EDU) Fri, 11 Sep 1998 18:36:43 -0400 

>I don't normally follow the TCP implementor's working group (*), so I
>don't know if they actually followed through on his suggestion;
>Matthais's note seems to indicate that they did.


I think it is just considered good practise to punish misbehaving users
at the moment. Not sure if any vendor has implemented anything yet.

There is an informational RFC out:
http://info.internet.isi.edu:80/in-notes/rfc/files/rfc2309.txt

Unfortunately, they dont mention remedies for misbehaving flows. They do
suggest RED; however, there are variants of RED that exist with specific
intention of punishing misbehaving users.

A really interesting pointer page is at:
http://www-nrg.ee.lbl.gov/floyd/tcp_unfriendly.html


cheers,
jamal


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
