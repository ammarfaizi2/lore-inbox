Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbTEFQFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263886AbTEFQFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:05:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24960
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263884AbTEFQFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:05:09 -0400
Subject: Re: X unlock bug revisited
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305061141300.1272-100000@oddball.prodigy.com>
References: <Pine.LNX.4.44.0305061141300.1272-100000@oddball.prodigy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052234284.1201.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 16:18:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 16:50, Bill Davidsen wrote:
> Some months ago I noted that a new kernel introduced a failure to be able 
> to unlock X after locking. Still there in 2.5.69 for RH 7.2, 7.3, and 8.0.

Its a pam bug triggered by the subtle scheduling timing changes and
fixed in Red Hat 9

