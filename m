Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUD2Axd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUD2Axd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUD2Axd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:53:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5592 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262322AbUD2Ax3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:53:29 -0400
Message-ID: <409051F1.80401@pobox.com>
Date: Wed, 28 Apr 2004 20:53:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040428205059.A4563@animx.eu.org>
In-Reply-To: <20040428205059.A4563@animx.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> This is just my oppinion.  I personally feel that cache should use available
> memory, not already used memory (swapping apps out for more cache).


Strongly agreed, though there are pathological cases that prevent this 
from being something that's easy to implement on a global basis.

	Jeff



