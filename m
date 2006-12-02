Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162914AbWLBKae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162914AbWLBKae (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 05:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759435AbWLBKae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:30:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15273 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1759434AbWLBKae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:30:34 -0500
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
From: Arjan van de Ven <arjan@infradead.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc>
In-Reply-To: <1164998179.5257.953.camel@gullible>
References: <1164998179.5257.953.camel@gullible>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 02 Dec 2006 11:30:32 +0100
Message-Id: <1165055432.3233.151.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 13:36 -0500, Ben Collins wrote:
> I'd be willing to bet that most distros have this patch in their kernel.
> One of those things we can't really live without.
> 
> What I haven't understood is why it isn't included in the mainline
> kernel yet.

it's not that hard ;)

replacing the DSDT code *while it's live* is just a bad idea. The kernel
already has a facility to override the DSDT, but that one does it *from
the start*. Sounds like that one should be used or maybe enhanced a
little to make it more distro friendly if something is lacking.



