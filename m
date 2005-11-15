Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVKOUbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVKOUbD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 15:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVKOUbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 15:31:02 -0500
Received: from kanga.kvack.org ([66.96.29.28]:28290 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965017AbVKOUbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 15:31:00 -0500
Date: Tue, 15 Nov 2005 15:28:27 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Lee <linuxtwidler@gmail.com>
Cc: linux-kernel@vger.kernel.org, pageexec@freemail.hu
Subject: Re: 4k stack overflow and stack traces
Message-ID: <20051115202827.GC31988@kvack.org>
References: <20051110083525.6cfe6f35@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110083525.6cfe6f35@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 08:35:25AM -0600, Lee wrote:
> Is there a way to get a stacktrace in this case so we can identify which 
> execution path is causing this stack overflos ?

It could be done...  Before coming up with a patch for that, what sort of 
setup are you running -- filesystem, raid array, drivers, etc?  Combined 
with the results of a 'make checkstack' that's usually enough to get an 
idea where the problem is.  Thanks,

		-ben
