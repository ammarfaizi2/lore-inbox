Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbUBAVCU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265468AbUBAVCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:02:20 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:10745 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265452AbUBAVCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:02:18 -0500
From: Christian Borntraeger <kernel@borntraeger.net>
To: Markus =?iso-8859-1?q?H=E4stbacka?= <midian@ihme.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Uptime counter
Date: Sun, 1 Feb 2004 22:02:06 +0100
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.44.0402012239010.6206-100000@midi>
In-Reply-To: <Pine.LNX.4.44.0402012239010.6206-100000@midi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200402012202.07204.kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Hästbacka wrote:
> Hi list,
> I wonder does any kernel branch have a uptime counter that doesn't stop
> counting at 497 days? Or is a patch needed for the job to
> 2.{0,2,4,6} kernel?

In 2.6 there is no 497 days limit, as jiffies are now 64 bit. 

By the way: Having a machine with more than 497 days of uptime normally 
shows a serios lack of security awareness..

cheers 

Christian

