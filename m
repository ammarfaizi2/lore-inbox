Return-Path: <linux-kernel-owner+w=401wt.eu-S964944AbXAJSZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbXAJSZZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 13:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbXAJSZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 13:25:24 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:60120 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964944AbXAJSZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 13:25:24 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45A52F86.8090003@s5r6.in-berlin.de>
Date: Wed, 10 Jan 2007 19:25:10 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: macros:  "do-while" versus "({ })" and a compile-time error
References: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain> <45A3D1DF.4020205@s5r6.in-berlin.de> <Pine.LNX.4.61.0701091415200.12545@chaos.analogic.com> <Pine.LNX.4.64.0701100116420.10133@localhost.localdomain> <Pine.LNX.4.61.0701100715330.16104@chaos.analogic.com> <Pine.LNX.4.64.0701100841150.3216@CPE00045a9c397f-CM001225dbafb6>
In-Reply-To: <Pine.LNX.4.64.0701100841150.3216@CPE00045a9c397f-CM001225dbafb6>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
[...]
> what the above implies is
> that the ALIGN() macro can *never* be extended in that way because of
> the way it's being used in the struct definition above, outside of a
> function.
> 
> doesn't that place an unnecessarily limit on what might be done with
> ALIGN() in the future?
[...]

The one occurrence which is different from others could be changed.

But more importantly: Don't overuse macros.
-- 
Stefan Richter
-=====-=-=== ---= -=-=-
http://arcgraph.de/sr/
