Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278690AbRKFI4M>; Tue, 6 Nov 2001 03:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278701AbRKFI4C>; Tue, 6 Nov 2001 03:56:02 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:21127 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S278690AbRKFIzp>;
	Tue, 6 Nov 2001 03:55:45 -0500
Message-ID: <3BE7A58F.7BFEAAEE@pobox.com>
Date: Tue, 06 Nov 2001 00:55:43 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "James A. Hillyerd" <james@hillyerd.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: TCP Connections stuck in SYN_SENT state with 2.4.12, 2.4.13, 2.4.14
In-Reply-To: <1005036240.978.6.camel@makita>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"James A. Hillyerd" wrote:

> I have a strange problem, outgoing TCP packets get stuck at the SYN_SENT
> point for certain websites.  Two of the sites I have this problem with
> are zdnet.com and compusa.com.  When I try to telnet to port 80, the
> connection will never be established, and netstat shows it in the
> SYN_SENT state.

Did you by chance enable ecn in the kernel?

Try:

echo "0" > /proc/sys/net/ipv4/tcp_ecn

This is a FAQ IIRC -

cu

jjs

