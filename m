Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLOHtN>; Fri, 15 Dec 2000 02:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbQLOHtD>; Fri, 15 Dec 2000 02:49:03 -0500
Received: from ivanova.coker.com.au ([203.36.46.209]:28170 "HELO
	ivanova.coker.com.au") by vger.kernel.org with SMTP
	id <S129267AbQLOHsv> convert rfc822-to-8bit; Fri, 15 Dec 2000 02:48:51 -0500
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: userlink
Date: Fri, 15 Dec 2000 07:08:51 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <0012150708513C.00826@lyta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to port the Userlink driver (used for IPsec) to 2.4.0-test10.  I 
have 2 questions:
Firstly has anyone already done this?

Secondly, how do I re-write the following code to work with 2.4.0?

static int
net_ul_start(struct net_device *dev)
{
    dev->start = 1;
    dev->tbusy = 0;
    return(0);
} 

Thanks.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
