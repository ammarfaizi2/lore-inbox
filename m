Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423285AbWF1LrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423285AbWF1LrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423286AbWF1LrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:47:09 -0400
Received: from styx.suse.cz ([82.119.242.94]:39098 "EHLO elijah.suse.cz")
	by vger.kernel.org with ESMTP id S1423285AbWF1LrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:47:08 -0400
Subject: Re: Kernel API Reference Documentation
From: Petr Tesarik <ptesarik@suse.cz>
To: Lukas Jelinek <info@kernel-api.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44A1858B.9080102@kernel-api.org>
References: <44A1858B.9080102@kernel-api.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: SuSE CR
Date: Wed, 28 Jun 2006 13:47:05 +0200
Message-Id: <1151495225.8127.68.camel@elijah.suse.cz>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 21:22 +0200, Lukas Jelinek wrote:
> Hello,
> 
> a few months ago I looked for something like "Linux Kernel API Reference
> Documentation". This search was unsuccessful and somebody recommended me
> to generate this documentation from the kernel headers.
> 
> I have used Doxygen for this work. But the headers have needed to be
> preprocessed by 'sed' using some regexp rules (due to various
> incompatible comment formats).
> 
> Now I decide to share the result worldwide. The current generated
> "Kernel API Reference" can be found at http://www.kernel-api.org.
> Although it is very buggy this time I think it may be useful for module
> developers.

I looked at
http://www.kernel-api.org/docs/online/2.6.17/da/dab/structsk__buff.html

and you apparently ignore kernel-doc for structs. Cf.
include/linux/skbuff.h:177 ff.

Regards,
Petr Tesarik

