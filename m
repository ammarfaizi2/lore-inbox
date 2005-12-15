Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbVLOBFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbVLOBFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVLOBFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:05:05 -0500
Received: from mail.guam.net ([202.128.0.37]:32968 "EHLO asa.kuentos.guam.net")
	by vger.kernel.org with ESMTP id S965144AbVLOBFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:05:02 -0500
From: "Michael D. Setzer II" <mikes@kuentos.guam.net>
To: linux-kernel@vger.kernel.org
Date: Thu, 15 Dec 2005 11:03:05 +1000
MIME-Version: 1.0
Subject: OT: name resolution problem with cd based kernel
Message-ID: <43A14D69.10426.A507EF@mikes.kuentos.guam.net>
X-PM-Encryptor: QDPGP, 4
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Not sure where the problem is coming from. If it is a kernel build 
problem, or a missing support file(s) problem. I've been working on 
g4l (Ghost for linux) and have been able to build additional nic and 
other support by using the later kernel.org kernels. That has all 
worked well. But I'm know trying to get the system to support the 
use of names rather than just ip addresses. The system can 
currently ping by ip number, but ping by name comes back with 
unknown server error. traceroute doesn't work with number or 
name. traceroute with ip number gives unknown protocol icmp, but 
ping works, and the messages I found on this problem point to 
missing /etc/protocols file, but I added that with no change.
traceroute with name give Unknown server error.
nslookup also gives unknown server error.

The g4l uses ncftp with no problem to upload images via the net 
using ip, but no name support. If I could add the support without 
major work, I would like to. I had about 9000 downloads of the new 
version files in November, so am hoping people find the program 
useful. To me using ip numbers is no problem, but some have asked 
for it. 

If anyone has an answer, or a place that I could look to find it. 
Currently, the system just uses the bzImage file, and mostly 
busybox for the system, and a few statically compiled programs.

Thanks.

+----------------------------------------------------------+
  Michael D. Setzer II -  Computer Science Instructor      
  Guam Community College  Computer Center                  
  mailto:mikes@kuentos.guam.net                            
  mailto:msetzerii@gmail.com
  http://www.guam.net/home/mikes
  Guam - Where America's Day Begins                        
+----------------------------------------------------------+

http://setiathome.berkeley.edu
Number of Seti Units Returned:  18,823
Processing time:  32 years, 168 days, 23 hours, 32 minutes
(Total Hours: 284,376)


-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8 -- QDPGP 2.61c
Comment: http://community.wow.net/grt/qdpgp.html

iQA/AwUBQ6A0KyzGQcr/2AKZEQKHIgCg91r4OdCuVxOB5bl7fbB25J6Pex8AoIQl
j8njG0WqO/SEFNYo2TVEuxNP
=hoeu
-----END PGP SIGNATURE-----

