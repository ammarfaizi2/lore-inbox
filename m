Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbUD3WlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUD3WlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUD3WlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:41:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:45794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261742AbUD3WkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:40:22 -0400
Date: Fri, 30 Apr 2004 15:42:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: FabF <Fabian.Frederick@skynet.be>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH 2.6.6-rc3-mm1] Add maxthinktime to sysfs
Message-Id: <20040430154246.2019f9ec.akpm@osdl.org>
In-Reply-To: <1083364002.6303.9.camel@bluerhyme.real3>
References: <1083364002.6303.9.camel@bluerhyme.real3>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF <Fabian.Frederick@skynet.be> wrote:
>
> 	Here's a patch to add the asio maxthinktime to sysfs.

Why?  Have you measured any benefit from varying it, and if so, what was
the result?

Badari, did you find any need to vary this in the AS tuning work which you
were doing?  (What happened to that, btw?)

If we're going to expose this tunable to users it needs to be documented in
as-iosched.txt
