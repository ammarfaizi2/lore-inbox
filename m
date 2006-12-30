Return-Path: <linux-kernel-owner+w=401wt.eu-S1030274AbWL3Emx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWL3Emx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 23:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWL3Emx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 23:42:53 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45434 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030274AbWL3Emw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 23:42:52 -0500
Date: Fri, 29 Dec 2006 20:42:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Print sysrq-m messages with KERN_INFO priority
Message-Id: <20061229204247.be66c972.akpm@osdl.org>
In-Reply-To: <E1H0Uq5-0003Fo-1W@candygram.thunk.org>
References: <E1H0Uq5-0003Fo-1W@candygram.thunk.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 22:24:53 -0500
"Theodore Ts'o" <tytso@mit.edu> wrote:

> Print messages resulting from sysrq-m with a KERN_INFO instead of the
> default KERN_WARNING priority

hm, I wonder why.  If someone does sysrq-<whatever> then they presumably want
to display the result?  Tricky.

Is this patch a consistency thing?
