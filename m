Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281311AbRKTTzQ>; Tue, 20 Nov 2001 14:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281308AbRKTTzI>; Tue, 20 Nov 2001 14:55:08 -0500
Received: from ppp15.atlas-iap.es ([194.224.1.15]:772 "EHLO mcrg")
	by vger.kernel.org with ESMTP id <S281311AbRKTTyz>;
	Tue, 20 Nov 2001 14:54:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: Re: problem with NAT on 2.4
Date: Tue, 20 Nov 2001 20:54:43 +0100
X-Mailer: KMail [version 1.3.2]
Cc: skraw@ithnet.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011120195443.6842910619@mcrg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > Does anybody have an idea why NAT in 2.4.10 wouldn't work like NAT in some
 > cheap dsl-router equipment regarding http-connections?
 > Is there any sense in upgrading to 2.4.15-preX?
 > I even tried some gateway software based on windoze that is able to NAT - 
and
 > it works too! I pretty much ran out of ideas...

Did you disable ECN? (echo 0 > /proc/sys/net/ipv4/tcp_ecn)

Did you try a connection to port 80 from the Linux box?

--ricardo
