Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTDNW73 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264008AbTDNW72 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:59:28 -0400
Received: from freeside.toyota.com ([63.87.74.7]:6302 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP id S264007AbTDNW70 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:59:26 -0400
Message-ID: <3E9B400D.60403@tmsusa.com>
Date: Mon, 14 Apr 2003 16:11:09 -0700
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: 2.5.67-mm3 report 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After working around the video symbols compile issue, 2.5.67-mm3
seems to be mostly happy here -

There's an interesting new buglet in 2.5.67-mm3, which I see on both
boxes here which have booted 2.5.67-mm3 - I don't see this in -mm2.

The symptom here is that running the "ruptime" command on an -mm3
box shows all hosts down -

Interestingly, the other hosts are getting the rwho broadcasts from
the -mm3 box, but the -mm3 box is unable to process rwho broadcasts,
including  it's own -


Cheers,

Joe


