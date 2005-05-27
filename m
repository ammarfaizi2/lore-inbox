Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVE0QAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVE0QAy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 12:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVE0QAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 12:00:53 -0400
Received: from mail.dvmed.net ([216.237.124.58]:38623 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262483AbVE0QAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 12:00:49 -0400
Message-ID: <4297442A.8080300@pobox.com>
Date: Fri, 27 May 2005 12:00:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ support
References: <20050527070353.GL1435@suse.de> <20050527131842.GC19161@merlin.emma.line.org>
In-Reply-To: <20050527131842.GC19161@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> OK, so this is for AHCI. What are the options for people whose
> mainboards aren't blessed with AHCI, but use for instance VIA or older
> Promise chips? Buy new hardware? Or wait until someone comes up with an
> implementation?


As Jens mentioned, NCQ support requires both device and hardware have 
explicit NCQ support.  That eliminates most of Linux's supported SATA 
controllers, none of which support NCQ.

Don't have a heart attack, though, SATA is pretty fast even without NCQ.

	Jeff


