Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292792AbSCOPTN>; Fri, 15 Mar 2002 10:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292817AbSCOPTG>; Fri, 15 Mar 2002 10:19:06 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:33670 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S292733AbSCOPSt>;
	Fri, 15 Mar 2002 10:18:49 -0500
Message-ID: <3C92111C.1070107@nokia.com>
Date: Fri, 15 Mar 2002 17:19:56 +0200
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011023
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
CC: affix-devel@lists.sourceforge.net,
        Affix support <affix-support@lists.sourceforge.net>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: New Affix Release: Affix-0_96  --- Bluetooth Protocol Stack. GUI available now.
In-Reply-To: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com> <3C6D25F6.4010905@nokia.com> <3C766511.5050808@nokia.com> <3C7F6C0C.6030204@nokia.com> <3C877AC7.8090008@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2002 15:18:47.0280 (UTC) FILETIME=[B3F79F00:01C1CC34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

Find new affix release Affix-0_96 on http://affix.sourceforge.net
This version has stability improvement.

GUI environment A.F.E - Affix Frontend Environment available for use.
http://affix.sourceforge.net/afe

Link can be found on Affix WEB site in *Links* section.


Version 0.96 [15.03.2002]
- [new] added field *local* to sockaddr_rfcomm to connect through
	certain Bluetooth adapter
	sockaddr_rfcomm {
	... old fields..
	BD_ADDR		local;
	}
	set *local* to Bluetooth address of the adapter to connect through.
	or BDADDR_ANY
- [new] SDP server works based on MTU
- [fix] SDP Continuation mecahnism - problems on client side.
	Did not work at all. (e.g. with Ericsson phone)
- [new] btctl prints Affix version



br, Dmitry

-- 
 Dmitry Kasatkin
 Nokia Research Center / Helsinki
 Mobile: +358 50 4836365
 E-Mail: dmitry.kasatkin@nokia.com



