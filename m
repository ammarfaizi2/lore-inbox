Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293631AbSCKGtM>; Mon, 11 Mar 2002 01:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSCKGtD>; Mon, 11 Mar 2002 01:49:03 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:25608 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S293631AbSCKGsv>; Mon, 11 Mar 2002 01:48:51 -0500
Message-Id: <200203110646.g2B6kWq03689@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Martin J. Bligh" <fletch@aracnet.com>, lse-tech@lists.sourceforge.net
Subject: Re: 23 second kernel compile (aka which patches help scalibility on NUMA)
Date: Mon, 11 Mar 2002 08:45:44 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <82825246.1015624024@[10.10.2.3]>
In-Reply-To: <82825246.1015624024@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 March 2002 03:47, Martin J. Bligh wrote:
> "time make -j32 bzImage" is now down to 23 seconds.
> (16 way NUMA-Q, 700MHz P3's, 4Gb RAM).
...
> Any other suggestions are welcome. I'd also be interested
> to know if 23s is fast for make bzImage, or if other big
> iron machines can kick this around the room.

I'm curious how long "time make -j32 bzImage" takes on your setup
when:
1) only one node is enabled,
2) only one CPU is enabled?

this will give you a clue how close you are to 'perfect' scalability.
--
vda
