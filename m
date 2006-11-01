Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945915AbWKABVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945915AbWKABVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945971AbWKABVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:21:21 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:48083 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1945915AbWKABVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:21:19 -0500
Message-ID: <4547F68A.9060007@pobox.com>
Date: Tue, 31 Oct 2006 20:21:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: David Rientjes <rientjes@cs.washington.edu>
CC: akpm@osdl.org, hch@infrared.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net s2io: return on NULL dev_alloc_skb()
References: <200610302117.24760.jesper.juhl@gmail.com> <Pine.LNX.4.64N.0610301415030.22754@attu2.cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0610301415030.22754@attu2.cs.washington.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> Checks for NULL dev_alloc_skb() and returns on true to avoid subsequent
> dereference.
> 
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: Christoph Hellwig <hch@infrared.org>
> Signed-off-by: David Rientjes <rientjes@cs.washington.edu>

applied


