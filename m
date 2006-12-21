Return-Path: <linux-kernel-owner+w=401wt.eu-S1161055AbWLUAqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWLUAqy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbWLUAqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:46:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53938 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161055AbWLUAqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:46:53 -0500
Date: Wed, 20 Dec 2006 16:46:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Rewrite unnecessary duplicated code to use
 FIELD_SIZEOF().
Message-Id: <20061220164651.4ee2e960.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612170738410.24046@localhost.localdomain>
References: <Pine.LNX.4.64.0612170738410.24046@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2006 07:43:39 -0500 (EST)
"Robert P. J. Day" <rpjday@mindspring.com> wrote:

>   as with ARRAY_SIZE(), there are a number of places (mercifully, far
> fewer) that recode what could be done with the FIELD_SIZEOF() macro in
> kernel.h.
> 

Looks sane.

>  include/acpi/actbl.h                    |    2 -

I dropped this hunk.  I don't think that's a Linux-only file.
