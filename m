Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUH0QGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUH0QGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266347AbUH0QGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:06:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:52617 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266311AbUH0QGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:06:46 -0400
Message-ID: <412F5C21.7090909@sgi.com>
Date: Fri, 27 Aug 2004 11:06:57 -0500
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com> <412F4EC9.7050003@sgi.com> <20040827165443.A32567@infradead.org>
In-Reply-To: <20040827165443.A32567@infradead.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Aug 27, 2004 at 10:10:01AM -0500, Patrick Gefre wrote:
> 
>>This is an update to our last set of patches. I've added some comments from the
>>last review and another synopsis of the patches. The individual patches will
>>follow this email.
> 
> 
> Matthew Wilcox suggested we should really review it as completely new
> code.  So maybe you should split it into one patch that kills all old
> code end one that adds new code.  Note that I mean all all code includeing
> the headers which provides a nice opporuntiy to move all of them that
> aren't public interface inside arch/ia64/sn/
> 

This makes sense. I'll start working on this right away.
