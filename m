Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274859AbTHFMT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 08:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274997AbTHFMT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 08:19:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10689 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S274859AbTHFMT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 08:19:26 -0400
Message-ID: <3F30F237.5070502@pobox.com>
Date: Wed, 06 Aug 2003 08:19:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: Add identify decoding 4/4
References: <UTC200308060723.h767N2T02315.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200308060723.h767N2T02315.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> Here a somewhat uneven commented ide_identify.h.
> This is part of a larger patch, but suffices for now.


Do you really want to stick that long function in a header?

Stick it in ide-lib.c, that's a better place for it, IMO...

	Jeff



