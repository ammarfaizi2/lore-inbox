Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTEGGWd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTEGGWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:22:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48109 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262902AbTEGGWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:22:33 -0400
Date: Tue, 06 May 2003 22:27:29 -0700 (PDT)
Message-Id: <20030506.222729.35034981.davem@redhat.com>
To: hch@infradead.org
Cc: dwmw2@infradead.org, thomas@horsten.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030507072830.A7586@infradead.org>
References: <20030507072002.A7424@infradead.org>
	<20030506.221900.38693097.davem@redhat.com>
	<20030507072830.A7586@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Wed, 7 May 2003 07:28:30 +0100
   
   rtnetlink.h is a bad example.  Just to use something you quoted earlier in
   this thread..
   
What is wrong with it?  Truly kernel-only elements are protected
with __KERNEL__ the rest are only the user visible and normal
C types that are necessary for using rtnetlink in user apps.
