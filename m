Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268790AbTGJCAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 22:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268791AbTGJCAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 22:00:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55719 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S268790AbTGJCAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 22:00:46 -0400
Date: Wed, 09 Jul 2003 19:06:56 -0700 (PDT)
Message-Id: <20030709.190656.23035889.davem@redhat.com>
To: wa@almesberger.net
Cc: hch@infradead.org, jmorris@intercode.com.au, TSPAT@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030709230637.A6409@almesberger.net>
References: <20030709220825.A22087@almesberger.net>
	<20030709.180830.39180836.davem@redhat.com>
	<20030709230637.A6409@almesberger.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Werner Almesberger <wa@almesberger.net>
   Date: Wed, 9 Jul 2003 23:06:37 -0300

   Considering only inline functions, 64 of the 89 functions my script
   below finds in my 2.5.72 tree are only used in net/ipv4 (or tcp.h
   itself). That's almost 72%. Only 22 of the functions (25%) are used
   in net/ipv6.
   
I was considering structure definitions, macros, and whatnot
as well.
