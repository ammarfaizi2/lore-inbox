Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155382AbQATW6D>; Thu, 20 Jan 2000 17:58:03 -0500
Received: by vger.rutgers.edu id <S155623AbQATUn4>; Thu, 20 Jan 2000 15:43:56 -0500
Received: from mea.tmt.tele.fi ([194.252.70.162]:2923 "EHLO mea.tmt.tele.fi") by vger.rutgers.edu with ESMTP id <S154000AbQATTVj>; Thu, 20 Jan 2000 14:21:39 -0500
Date: Thu, 20 Jan 2000 21:21:29 +0200
From: Matti Aarnio <matti.aarnio@sonera.fi>
To: linux-hams@vger.rutgers.edu, linux-kernel@vger.rutgers.edu, linux-newbie@vger.rutgers.edu, linux-net@vger.rutgers.edu
Subject: If you have incoming email problems..
Message-ID: <20000120212129.S722@mea.tmt.tele.fi>
Reply-To: mea@vger.rutgers.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

*many* people have rather spodaric email reachability thru VGER's
lists, which has nothing to do with recently so volumously spoken
about DNS based address blocking systems.

Listadmins keep kicking people out of lists after getting permanent
errors (so called '500-series'), which may well be only due to
temporary traversal thru backup MX server which doesn't like your
domain..

I suggest all of you do check that the email domain you use does
have fully functional backup MX servers.

Because doing that test is
  a)  difficult without accounts at systems outside your backup-MX's
      local service domain
  b)  somewhat involved technically
I have created a CGI utility with which you can do it trivially by
entering the domain name that you use, and pressing ENTER..

   http://www.zmailer.org/mxverify-cgi.html


If you need help at fixing your backups, or DNS, or whatever,
_I_ am wrong person to ask for help (lack of time), I think
that   linux-newbie  (primarily) and  linux-net  (for more
involved questions) are more suitable forums.

There are also heaps of HOWTOs about email and DNS.


If you want to install this tool to some system which could do
this probing too, you are welcome to talk with me.  To compile
it you need ZMailer sources, but it runs without ZM.

Oh, and natively 6BONE connected WWW server would be nice one
for running this too :)     If your server can support IPv6
connections, and any of MX systems have AAAA records, this
tester will try connection over IPv6 to them too!

/Matti Aarnio <mea@nic.funet.fi>  (and *many* other hats)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
