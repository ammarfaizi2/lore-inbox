Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTEAXpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 19:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTEAXpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 19:45:51 -0400
Received: from rth.ninka.net ([216.101.162.244]:46553 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262787AbTEAXpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 19:45:50 -0400
Subject: Re: kernel BUG at net/socket.c:147
From: "David S. Miller" <davem@redhat.com>
To: "Michael D. Harnois" <mharnois@cpinternet.com>
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br
In-Reply-To: <1051821220.4440.1.camel@mharnois.mdharnois.net>
References: <1051821220.4440.1.camel@mharnois.mdharnois.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051822567.10731.1.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 13:56:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-01 at 13:33, Michael D. Harnois wrote:
> May  1 15:30:20 mharnois kernel: Process vmnet-bridge (pid: 9886,

VMWARE is buggy in it's socket/protocol handling.

Arnaldo, it triggered the net_family_bug() :-)

-- 
David S. Miller <davem@redhat.com>
