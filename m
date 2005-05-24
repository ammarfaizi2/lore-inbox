Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVEXMXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVEXMXi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVEXMXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:23:38 -0400
Received: from [194.90.79.130] ([194.90.79.130]:50443 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S262025AbVEXMXG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:23:06 -0400
Subject: Re: Issues with INET sockets through loopback (lo)
From: Avi Kivity <avi@argo.co.il>
To: Hans Henrik Happe <hhh@imada.sdu.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200505231317.44716.hhh@imada.sdu.dk>
References: <200505231317.44716.hhh@imada.sdu.dk>
Content-Type: text/plain; charset=utf-8
Date: Tue, 24 May 2005 15:23:02 +0300
Message-Id: <1116937382.1848.9.camel@blast.qumranet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 24 May 2005 12:23:03.0964 (UTC) FILETIME=[5551C5C0:01C5605B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-23 at 13:17 +0200, Hans Henrik Happe wrote:

> I hope that others can comfirm that this is an issue or otherwise explain why 
> it is supposed behave this way.
> 

you might try using udp instead of tcp. this would help determine
whether the problem is in the tcp stack or the loopback interface.

nagle´s algorithm was my initial suspect but I see you took care of
that.



