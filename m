Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271667AbRIROxB>; Tue, 18 Sep 2001 10:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271711AbRIROwv>; Tue, 18 Sep 2001 10:52:51 -0400
Received: from mail2.aracnet.com ([216.99.193.35]:52753 "EHLO
	mail2.aracnet.com") by vger.kernel.org with ESMTP
	id <S271667AbRIROwf>; Tue, 18 Sep 2001 10:52:35 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Neulinger, Nathan" <nneul@umr.edu>, <linux-kernel@vger.kernel.org>
Subject: RE: How much performance hit from running SMP kernel on UP box?
Date: Tue, 18 Sep 2001 07:54:08 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBMEFODMAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: High
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D86D74D@umr-mail03.cc.umr.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This question as it stands is more or less meaningless, as are the rumored
values of 5-10%. There are two types of performance measures commonly used:
throughput -- the number of operations of a given type completed in a given
amount of time -- and response time -- the time it takes to complete a given
operation. To some extent, there are tradeoffs between the two. As load
increases, all other things being equal, throughput will increase and so
will response times for the operations. So I think the question you need to
be asking is, for any specific benchmark or application, "How does
throughput differ between the two environments with all other things -- load
and response time, for example -- being equal?" or "How does response time
differ between the two environments with all other things being equal?"

The other point I think needs to be made is that, while performance of the
*kernel* and its mechanisms is important to the folks on this list, it is
*not* for the most part what people buy computers for. For the most part,
people buy computers to accomplish *tasks*, for example running an
e-commerce business, processing astronomical images, editing documents,
creating electronic music, communicating with the Internet or operating a
manufacturing production line. How the *application code* performs, and *how
the kernel manages competing demands for resources from applications and
their users* are what matters. In other words, an inefficient kernel is a
bad thing, but inefficient applications on top of a perfect kernel are much
much worse.
--
M. Edward (Ed) Borasky
http://www.aracnet.com/~znmeb
mailto:znmeb@aracnet.com

Stand-Up Comedy: Because Man Does Not Live By Dread Alone

