Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTDPMMZ (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 08:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264333AbTDPMMZ 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 08:12:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58818
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264331AbTDPMMY (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 08:12:24 -0400
Subject: Re: [RFC] Port 0x80 writes considered harmful
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E9CF81F.F7CCCADF@daimi.au.dk>
References: <3E9CF81F.F7CCCADF@daimi.au.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050492360.28591.36.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Apr 2003 12:26:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-16 at 07:28, Kasper Dupont wrote:
> Then I inserted port 0x80 writes in the loop, and at that
> point there would be parallel port output during the entire
> execution of the loop.
> 
> What would be the best solution to my problem?

If the parallel port is picking up 0x80 writes then either its
at a very weird and very stupid address or its got some kind
of decode problem.


