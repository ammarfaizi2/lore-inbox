Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263672AbTDTSml (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263673AbTDTSmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:42:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9428 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263672AbTDTSmj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:42:39 -0400
Message-ID: <3EA2ECE5.2050100@pobox.com>
Date: Sun, 20 Apr 2003 14:54:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] silence some superfluous boot messages
References: <UTC200304201828.h3KISHp18103.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200304201828.h3KISHp18103.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> I suppose these can be removed altogether.
> For now #if 0 ... #endif.


would it not be preferable to mark these as KERN_DEBUG instead?

Sure they will still show up in dmesg, but that gives the code authors 
opportunity to themselves adjust the messages, mark them as DPRINTK(), 
or #if-0 them out themselves.

	Jeff



