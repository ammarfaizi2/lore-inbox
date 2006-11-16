Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424381AbWKPUEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424381AbWKPUEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424393AbWKPUEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:04:34 -0500
Received: from smtp-out.google.com ([216.239.45.12]:51639 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1424381AbWKPUEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:04:33 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=oVAbGlJFnxWg2nwahvGvN1f2+UyvAP/QmkZDmUSkFloaHeS1NuSias89ZD0D7SB5h
	ZsR/gzy6uaauHcdXwGFNw==
Message-ID: <455CC38A.20104@google.com>
Date: Thu, 16 Nov 2006 12:01:14 -0800
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Introduce block I/O performance histograms
References: <455BD7E8.9020303@google.com> <20061116065846.GE32394@kernel.dk>
In-Reply-To: <20061116065846.GE32394@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> I don't see the point at all for including this piece of code in the
> kernel. You can do the same from user space. Your help entry said it
> even grows the kernel size about 21k, that's pretty nasty.

How would you do this from user space?  Also, the 21k increase is only 
in effect if the feature is turned on in the config, and it's off by 
default.

	-ed falk
