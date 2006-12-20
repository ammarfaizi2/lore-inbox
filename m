Return-Path: <linux-kernel-owner+w=401wt.eu-S1161002AbWLTXCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWLTXCY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWLTXCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:02:24 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:32856 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161002AbWLTXCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:02:24 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4589C0E4.1060500@s5r6.in-berlin.de>
Date: Thu, 21 Dec 2006 00:01:56 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] New firewire stack - updated patches
References: <20061220005822.GB11746@devserv.devel.redhat.com> <458913AC.7080300@s5r6.in-berlin.de> <45897478.6070308@redhat.com> <45898785.4000209@s5r6.in-berlin.de> <458997B5.3040607@redhat.com> <4589B09E.40503@s5r6.in-berlin.de>
In-Reply-To: <4589B09E.40503@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> Because of the potentially much larger
> repeater delays of 1394b PHYs, the only suitable method to determine a
> working least gap count of such setups is round-trip delay measurement
> with ping packets. But a good compromise would be to run table-based gap
> count optimization for 1394a environments and no optimization for 1394b
> or mixed environments. (Even though the latter would also clearly
> benefit from it.)
               ^^  "it" == "a reduced gap count"
-- 
Stefan Richter
-=====-=-==- ==-- =-=--
http://arcgraph.de/sr/
