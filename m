Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbTHQMdR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 08:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbTHQMdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 08:33:17 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:59047 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269191AbTHQMdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 08:33:16 -0400
Message-ID: <3F3F77A8.4080106@t-online.de>
Date: Sun, 17 Aug 2003 14:40:08 +0200
From: Dominik.Strasser@t-online.de (Dominik Strasser)
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Strasser <dominik.strasser@t-online.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 oddities
References: <3F3F5E1D.3080600@t-online.de>
In-Reply-To: <3F3F5E1D.3080600@t-online.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: VrfkSmZdQel8ELzW3A8wOATk+CnQGuIgzUJiEWI8edal0hW1AbQi6w
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Strasser wrote:
> 1. My network card is not detected. It is a 3Com 3C509B EtherLink III, 
> which is correctly dtetcted by isapnp, but the card driver doesn't 
> recognize it. I don't have any network device. This seems to have 
> something to do with the ressources on my MB which is a Gigabyte 5-AA 
> which is an AT sized ATX MB. USB is disabled in the BIOS, but if I 
> enable USB in the kernel, a ressource conflict between the network card 
> and USB is reported. I am attaching my .config + the bootlog output.
Following up myself:
modprobing 3c509 worked. I didn't remember that I changed this one, too.
I'll retry with USB enabled.
OK, done. It works. I am sure, that test2 didn't. The PnP changes in 
test3 seem to have cured this problem. The other issues persist, though.

Dominik



