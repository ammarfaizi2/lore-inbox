Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273285AbRINElF>; Fri, 14 Sep 2001 00:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273287AbRINEk4>; Fri, 14 Sep 2001 00:40:56 -0400
Received: from nwcst281.netaddress.usa.net ([204.68.23.26]:20896 "HELO
	nwcst281.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S273285AbRINEkt> convert rfc822-to-8bit; Fri, 14 Sep 2001 00:40:49 -0400
Message-ID: <20010914044111.3882.qmail@nwcst281.netaddress.usa.net>
Date: 13 Sep 2001 23:41:11 CDT
From: shreenivasa H V <shreenihv@usa.net>
To: Mike Kravetz <kravetz@us.ibm.com>, shreenivasa H V <shreenihv@usa.net>
Subject: Re: [Re: scheduler policy]
CC: linux-kernel@vger.kernel.org
X-MSMail-Priority: High
X-Priority: 1
X-Mailer: USANET web-mailer (34FM.0700.21.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks, and I have a related question. Consider we have only 2 processes with
equal priority. Now one of them is switched out for an i/o operation. The
second one gains the cpu and executes past its time quantum. Since the other
process is not yet ready this process continues to enjoy the cpu. Now will
this usage be accounted for a new time quantum for this second process or will
it be unaccounted. According to what I understand, the second process will not
start its new time quantum until the epoch has ended i.e., the first one also
has finished its time quantum. So does this mean the epoch will never end
until there is a process in the system who's time quantum is yet to be
expired? 

shreeni.

