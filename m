Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbTDOAdT (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 20:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264017AbTDOAdT (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 20:33:19 -0400
Received: from [12.47.58.203] ([12.47.58.203]:11808 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263972AbTDOAdS (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 20:33:18 -0400
Date: Mon, 14 Apr 2003 17:44:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: jjs <jjs@tmsusa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm3 report
Message-Id: <20030414174434.07a2268a.akpm@digeo.com>
In-Reply-To: <3E9B400D.60403@tmsusa.com>
References: <3E9B400D.60403@tmsusa.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Apr 2003 00:45:01.0407 (UTC) FILETIME=[3F4B3EF0:01C302E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jjs <jjs@tmsusa.com> wrote:
>
> After working around the video symbols compile issue, 2.5.67-mm3
> seems to be mostly happy here -
> 
> There's an interesting new buglet in 2.5.67-mm3, which I see on both
> boxes here which have booted 2.5.67-mm3 - I don't see this in -mm2.
> 
> The symptom here is that running the "ruptime" command on an -mm3
> box shows all hosts down -
> 
> Interestingly, the other hosts are getting the rwho broadcasts from
> the -mm3 box, but the -mm3 box is unable to process rwho broadcasts,
> including  it's own -

Does it use IP multicast?  There were recent changes in there. 
CONFIG_IP_MULTICAST may need to be fiddled with.

