Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268741AbTGJBCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 21:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268749AbTGJBCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 21:02:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29607 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S268741AbTGJBCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 21:02:33 -0400
Date: Wed, 09 Jul 2003 18:08:30 -0700 (PDT)
Message-Id: <20030709.180830.39180836.davem@redhat.com>
To: wa@almesberger.net
Cc: hch@infradead.org, jmorris@intercode.com.au, TSPAT@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030709220825.A22087@almesberger.net>
References: <20030707080929.A1848@infradead.org>
	<20030707.195350.39170946.davem@redhat.com>
	<20030709220825.A22087@almesberger.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Werner Almesberger <wa@almesberger.net>
   Date: Wed, 9 Jul 2003 22:08:25 -0300
   
   E.g. most of include/net/tcp.h pretty much only matters for
   net/ipv4/. It would be so nice if a  grep -w thing *.[ch]  in
   net/ipv4/ would really find all uses of "thing".
   
Bad example, I'd say that %65 of that file is used in net/ipv6/*.c
files too.
