Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264893AbUEKRUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUEKRUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbUEKRUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:20:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20130 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264884AbUEKRUf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:20:35 -0400
Message-ID: <40A10B53.7030006@pobox.com>
Date: Tue, 11 May 2004 13:20:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gary Wong <gtw@cs.bu.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] Re: Segmentation fault in i810_audio.c:__i810_update_lvi
References: <20040510123607.T9078@cs.bu.edu> <20040511002728.46e05e4c.akpm@osdl.org> <20040511130656.A28363@cs.bu.edu>
In-Reply-To: <20040511130656.A28363@cs.bu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gary Wong wrote:
> OK, a patch is attached.  It seems to fix the problem on a 2.6.3 system
> with Herbert Xu's patches from Jeff Garzik applied.


Your patch looks OK to me.

I'll commit it to my 2.4 and 2.6 i810-audio queues, and send upstream 
after it gets some testing in Andrew's -mm (unless someone else objects 
to your patch, of course).

	Jeff



