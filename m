Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUAZMH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 07:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUAZMH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 07:07:59 -0500
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:39145 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S262603AbUAZMH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 07:07:58 -0500
Message-ID: <4015031C.F7CFA671@moving-picture.com>
Date: Mon, 26 Jan 2004 12:07:56 +0000
From: James Pearson <james-p@moving-picture.com>
Organization: Moving Picture Company
X-Mailer: Mozilla 4.7 [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Side effects of a <defunct> kswapd ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have number of machines that have <defunct> kswapd processes - I'm
fairly sure what is causing this - it's an issue with autofs v4 and a
'VFS: Busy inodes after unmount. Self-destruct in 5 seconds  Have a nice
day...' problem.

There are a few threads about this on the linux-nfs list - e.g.
http://marc.theaimsgroup.com/?t=106332683300004&r=1&w=2

Using autofs v4.1.0 appears to fix this problem.

However, I was wondering what would be the side effects of having a
<defunct> kswapd? - the box _appears_ to keep running fine (running
heavy CPU/memory applications).

Thanks

James Pearson
