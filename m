Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271825AbTHDVkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272050AbTHDVkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:40:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:30681 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271825AbTHDVkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:40:04 -0400
Date: Mon, 4 Aug 2003 14:41:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make lookup_create non-static
Message-Id: <20030804144129.3dfe4aac.akpm@osdl.org>
In-Reply-To: <20030804213543.GA1697@sgi.com>
References: <20030804213543.GA1697@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) wrote:
>
>  Make lookup_create non-static for use by certain pseudofilesystems (e.g.
>  hwgfs).

If one is patching ones kernel with hwgfs, once can include this chunk in
that patch, no?


