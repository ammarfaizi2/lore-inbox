Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVAMNCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVAMNCv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 08:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVAMNCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 08:02:51 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:12906 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261615AbVAMNCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 08:02:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=TEjgEkLAJc/4daccd+81CBqI/zXzQw2b+VbmcYWBqK07M2qhd8HcDU03qIwv8vs7mrUS9J6ZVzlz9Jrp2+s48xFDlEcHcKw9JAsgak4P00dlhxpvx9z+X0H5CSxMCmrRs7sjESg1v7CoNtfERY+6dBUSUwZB8crnhCwVErz/CL8=
Message-ID: <8105747b0501130502342acdca@mail.gmail.com>
Date: Thu, 13 Jan 2005 13:02:46 +0000
From: Johan Jordaan <aapman@gmail.com>
Reply-To: Johan Jordaan <aapman@gmail.com>
To: linux-kernel@vger.kernel.org, lartc@mailman.ds9a.nl
Subject: Bandwidth management under linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my search to control bandwidth on my network I found 2 projects..

1. TC
2. BWM Tools - http://freshmeat.net/projects/bwmtools/

This brings me to 2 questions...

Firstly, can TC control bandwidth in both directions? I read that it
can only do 1 direction, which one I cant remember. Can you monitor
the load on the queues you define? Does TC support IPv6?

Secondly, BWM Tools seems to queue traffic to userspace and use some
kind of kernel module to allow it through or not. How efficient is
bandwidth control using ip queing to userspace? BWM Tools doesn't seem
to support IPv6  :(

If anyone else knows of a way I can shape traffic, please let me know.

Regards
Johan
