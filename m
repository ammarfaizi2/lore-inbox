Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWAISMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWAISMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWAISMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:12:38 -0500
Received: from outgoing.tpinternet.pl ([193.110.120.20]:19137 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S964899AbWAISMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:12:38 -0500
In-Reply-To: <1136828040.9957.79.camel@mindpipe>
References: <5t06S-7nB-15@gated-at.bofh.it> <1136824149.5785.75.camel@tara.firmix.at> <1136824880.9957.55.camel@mindpipe>  <200601091753.36485.oliver@neukum.org> <1136827900.6659.66.camel@localhost.localdomain> <1136828040.9957.79.camel@mindpipe>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BBF4E2B4-40D8-4293-8D87-2B89FE45ECFB@neostrada.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       Bernd Petrovitsch <bernd@firmix.at>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Date: Mon, 9 Jan 2006 19:11:09 +0100
To: Lee Revell <rlrevell@joe-job.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Do most Linux GUI apps really render everything without regard to  
> what's
> obscured and what's visible?

Yes. Naive usage of backing store is right now pretty much the norm.  
However the
problem isn't the fact that the rendering occurs. The problem is that  
it occurs synchronously
and that composition is serializing with event handling.
