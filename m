Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269140AbUIXUys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269140AbUIXUys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269144AbUIXUys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:54:48 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:59612 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269140AbUIXUyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:54:46 -0400
Message-ID: <41548989.8040107@nortelnetworks.com>
Date: Fri, 24 Sep 2004 14:54:33 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <4154867F.7030108@nortelnetworks.com> <20040924134602.U1924@build.pdx.osdl.net>
In-Reply-To: <20040924134602.U1924@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

> The info is stored in the memory mapping info that's necessarily blown
> away at execve(2) because that's where you are overlaying a new image.

Yeah, I just saw that on the man page for mlockall.

I though maybe it was stored on the task struct or something.

Chris
