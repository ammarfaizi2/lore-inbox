Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUEQXHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUEQXHC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUEQXHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:07:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6568 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263107AbUEQXGf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:06:35 -0400
Message-ID: <40A9456B.1090305@pobox.com>
Date: Mon, 17 May 2004 19:06:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Robert Picco <Robert.Picco@hp.com>, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
References: <40A3F805.5090804@hp.com>	<40A40204.1060509@pobox.com>	<40A93DA5.4020701@hp.com> <20040517160508.63e1ddf0.akpm@osdl.org>
In-Reply-To: <20040517160508.63e1ddf0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Robert Picco <Robert.Picco@hp.com> wrote:
> 
>>O.K.  Did this but had to add a writeq and readq for i386.
> 
> 
> You implementation of these is private to hpet.c.  From what Jeff is
> saying, it looks like it should be in include/asm-i386/io.h?

Yep.

	Jeff




