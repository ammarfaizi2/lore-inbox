Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbVJVDTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbVJVDTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 23:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVJVDTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 23:19:19 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:35544 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932575AbVJVDTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 23:19:18 -0400
Date: Fri, 21 Oct 2005 20:18:59 -0700
From: Paul Jackson <pj@sgi.com>
To: Alex Williamson <alex.williamson@hp.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm trivial ia64/acpi breakage
Message-Id: <20051021201859.5a73d603.pj@sgi.com>
In-Reply-To: <1129580919.9621.33.camel@lts1.fc.hp.com>
References: <1129580919.9621.33.camel@lts1.fc.hp.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex wrote:
> -	if (resource->id != ACPI_RSTYPE_VENDOR)
> +	if (resource->type != ACPI_RSTYPE_VENDOR)

Yup - ia64 *.mm builds much better with this.  Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
