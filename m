Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263109AbUKTDoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbUKTDoA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 22:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUKTDn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 22:43:59 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:4049 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S263099AbUKTDnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 22:43:25 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kdump: Fix for boot problems on SMP
Date: Sat, 20 Nov 2004 12:46:42 +0900
User-Agent: KMail/1.5.4
Cc: hari@in.ibm.com, linux-kernel@vger.kernel.org, pbadari@us.ibm.com,
       varap@us.ibm.com
References: <419CACE2.7060408@in.ibm.com> <200411200256.36218.amgta@yacht.ocn.ne.jp> <20041119153052.21b387ca.akpm@osdl.org>
In-Reply-To: <20041119153052.21b387ca.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411201246.42343.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 November 2004 08:30, Andrew Morton wrote:
> So..  How is the crashdump code working now?  I haven't heard from anyone
> who is using it and I haven't gotten onto testing it myself.
>
> Do we have any feeling for its success rate on various machines, and on its
> ease of use?

Though I always genarate a panic intentionally on normal UP box,
(enable panic_on_oops, and generate kernel NULL pointer dereference)
It allways boot second-kernel successfully.

# gdb <first-kernel> -c /proc/vmcore
...

"up" or "down", and it displays the correct local/global values with "print"





