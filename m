Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUHUUq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUHUUq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267859AbUHUUq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:46:28 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:19927 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267860AbUHUUqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:46:14 -0400
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
From: Lee Revell <rlrevell@joe-job.com>
To: Josan Kadett <corporate@superonline.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1093120934.854.155.camel@krustophenia.net>
References: <1093120934.854.155.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1093121172.854.157.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 16:46:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 17:41, Josan Kadett wrote:
> I added the patch, indeed this was just one of the few modifications I tried
> before. The result is failure, the TCP/IP stack still does the checksum...
> Perhaps after this modification, the condition that the packet is not
> "eaten" may not be telling the system that there is a checksum error, but
> instead, just dropping packets by not igniting the TCP ACK function.

Please try Kalin's suggestion, instead of my patch.  It's more generic,
plus my 'patch' didn't handle UDP.

Lee

