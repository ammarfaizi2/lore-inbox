Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTFJAAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 20:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTFJAAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 20:00:21 -0400
Received: from dyn-ctb-203-221-72-225.webone.com.au ([203.221.72.225]:40464
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262312AbTFJAAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 20:00:18 -0400
Message-ID: <3EE522AA.7020200@cyberone.com.au>
Date: Tue, 10 Jun 2003 10:13:30 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Pratt <slpratt@austin.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70-mm2 causes performance drop of random read O_DIRECT
References: <3EE5190D.3070401@austin.ibm.com>
In-Reply-To: <3EE5190D.3070401@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Steven Pratt wrote:

> Starting in 2.5.70-mm2 and continuing in the mm tree, there is a 
> significant degrade in random read for block devices using O_DIRECT.   
> The drop occurs for all block sizes and ranges from 30%-40.  CPU usage 
> is also lower although it may already be so low as to be irrelavent.


Hi Steven, this is quite likely to be an io scheduler problem.
Is your test program rawread v2.1.5? What is the command line
you are using to invoke the program?


