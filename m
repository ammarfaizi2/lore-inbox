Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272639AbTHFV0D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272627AbTHFV0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:26:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64649 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272639AbTHFVZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:25:56 -0400
Message-ID: <3F317257.9040807@pobox.com>
Date: Wed, 06 Aug 2003 17:25:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: Add identify decoding 4/4
References: <UTC200308061351.h76Dp6413498.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200308061351.h76Dp6413498.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> No. <linux/ide-identify.h> contains a lot of 1-line static inline
> functions, just readable names for current magic bit checks,
> and one big function ide_dump_identify_info() that is included as
> 
> #ifdef IDE_IDENTIFY_DEBUG


Yes, I understand how the C pre-processor works, thanks ;-)

I know full well _why_ the big function is in the header; that doesn't 
address my point:  we don't need to be putting big functions in header 
files.  That's why libraries were invented :)

	Jeff



