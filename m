Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSGQQPk>; Wed, 17 Jul 2002 12:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSGQQPk>; Wed, 17 Jul 2002 12:15:40 -0400
Received: from web14806.mail.yahoo.com ([216.136.224.222]:60178 "HELO
	web14806.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315279AbSGQQPj>; Wed, 17 Jul 2002 12:15:39 -0400
Message-ID: <20020717161834.12994.qmail@web14806.mail.yahoo.com>
Date: Wed, 17 Jul 2002 09:18:34 -0700 (PDT)
From: spy9599 <spy9599@yahoo.com>
Subject: Is TCP CA_LOSS to CA_RECOVERY possible
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question regrading the TCP implementation. I
am not subscribed to this list, so please cc your
response.

In the present TCP (2.5.x) implementation, the TCP
sender never exits TCP_CA_Loss state until all packets
upto high_seq are acknowledged. But lets say while
doing retransmissions, some packet less than high_seq
are lost again. Ideally the TCP sender should just
enter fast retransmit and fast recovery, but from the
present implementation it seems the only way to come
out of it is after a timeout. 

Could somebody explain this to me please.

Thank you very much.
Best Regards
--SPY

__________________________________________________
Do You Yahoo!?
Yahoo! Autos - Get free new car price quotes
http://autos.yahoo.com
