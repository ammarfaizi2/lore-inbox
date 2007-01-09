Return-Path: <linux-kernel-owner+w=401wt.eu-S932202AbXAIUTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbXAIUTc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 15:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbXAIUTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 15:19:32 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35573 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202AbXAIUTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 15:19:32 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45A3F8C5.5060409@s5r6.in-berlin.de>
Date: Tue, 09 Jan 2007 21:19:17 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: macros:  "do-while" versus "({ })" and a compile-time error
References: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain> <45A3D1DF.4020205@s5r6.in-berlin.de> <Pine.LNX.4.61.0701091415200.12545@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0701091415200.12545@chaos.analogic.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Tue, 9 Jan 2007, Stefan Richter wrote:
>> The limitations are certainly highly compiler-specific.
> 
> I don't think so.

I referred to the ({ expr; }) in this remark, not to do-while. It's not
a valid construct in many flavors of the C language in the first place.
Also, occurrences of ({ expr; }) could be expandable to a constant
expression but would still not be accepted by gcc's parser outside of
functions.
-- 
Stefan Richter
-=====-=-=== ---= -=--=
http://arcgraph.de/sr/
