Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVDNKAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVDNKAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 06:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVDNKAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 06:00:54 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:55714 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261468AbVDNKAu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 06:00:50 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] genalloc for 2.6.12-rc-mm3
References: <16987.39669.285075.730484@jaguar.mkp.net>
	<20050412031502.3b5d39fc.akpm@osdl.org>
	<yq0br8k12nd.fsf@jaguar.mkp.net> <20050412144720.GA19894@lst.de>
	<yq03btw121j.fsf@jaguar.mkp.net> <20050412150015.GA20219@lst.de>
From: Jes Sorensen <jes@wildopensource.com>
Date: 14 Apr 2005 06:00:47 -0400
In-Reply-To: <20050412150015.GA20219@lst.de>
Message-ID: <yq0vf6pznhs.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph> On Tue, Apr 12, 2005 at 10:51:20AM -0400, Jes Sorensen
Christoph> wrote:
>> >>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:
>> 
>> >> +#include <asm/pal.h>
Christoph> this will break on all plattforms except alpha and ia64.
>>  The driver is located in arch/ia64/kernel/ ;-)

Christoph> Above hunk is from lib/genalloc.c

DOH! I'll send Andrew an updated patch with just this change to keep
l-k size down.

Thanks,
Jes
