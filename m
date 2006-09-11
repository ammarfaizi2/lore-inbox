Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWIKNtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWIKNtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 09:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWIKNtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 09:49:07 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:36787 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750776AbWIKNtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 09:49:03 -0400
Message-ID: <4505694D.5020304@garzik.org>
Date: Mon, 11 Sep 2006 09:49:01 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in libata-dev.git
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com>
In-Reply-To: <450568F3.3020005@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Shtylyov wrote:
>    It's not likely I'll be able to try it. But I'm absolutely sure that 
> drive aborted the read commands with the sector count of 0 (i.e. 256 
> actually). The exact model was IBM DHEA-34331.
>    255 sectors actually seems more safe bet.

This sort of thing should be handled by quirks, depending on the 
controller and drive.

That's why I was asking for testing, to see if the current code already 
handles this.

	Jeff


