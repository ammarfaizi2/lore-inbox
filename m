Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbTJJIeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTJJIeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:34:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46818 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262672AbTJJIeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:34:13 -0400
Date: Fri, 10 Oct 2003 01:27:59 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Douglas Leith" <doug@eee.strath.ac.uk>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru, jmorris@intercode.com.au, yoshfuji@linux-ipv6.org
Subject: Re: patch to implement RFC3517 in linux 2.4.22
Message-Id: <20031010012759.3e5e400f.davem@redhat.com>
In-Reply-To: <E1A7VCe-0001lZ-00@hermes.eee.strath.ac.uk>
References: <E1A7VCe-0001lZ-00@hermes.eee.strath.ac.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003 07:27:15 -0000
"Douglas Leith" <doug@eee.strath.ac.uk> wrote:

> Comments appreciated.

1) Why do you only update the scorebord in the reno case?  All the
   retransmission modes need it to be updated.

2) You really need to fix the super-long lines, the code becomes
   unreadable after your changes.

Alexey, comments?
