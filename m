Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVDHRuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVDHRuR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbVDHRtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:49:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:57778 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262907AbVDHRs4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:48:56 -0400
Date: Fri, 8 Apr 2005 10:48:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?SvZybg==?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] restrict inter_module_* to its last users
Message-Id: <20050408104826.3ca70fb4.akpm@osdl.org>
In-Reply-To: <20050408170805.GE2292@wohnheim.fh-wedel.de>
References: <20050408170805.GE2292@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
>
> Next step for inter_module removal.  This patch makes the code
>  conditional on its last users and shrinks the kernel binary for the
>  huge majority of people.

If we do this, nobody will get around to fixing up the remaining users.
