Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWHTRzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWHTRzr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWHTRzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:55:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23490 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751097AbWHTRzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:55:45 -0400
Subject: Re: [PATCH] getsockopt() early argument sanity checking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060819230532.GA16442@openwall.com>
References: <20060819230532.GA16442@openwall.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:15:56 +0100
Message-Id: <1156097756.4051.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-20 am 03:05 +0400, ysgrifennodd Solar Designer:
> The patch makes getsockopt(2) sanity-check the value pointed to by
> the optlen argument early on.  This is a security hardening measure
> intended to prevent exploitation of certain potential vulnerabilities in
> socket type specific getsockopt() code on UP systems.
> 
> This change has been a part of -ow patches for some years.

Is it in 2.6 ?

