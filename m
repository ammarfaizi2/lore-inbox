Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTHYR5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 13:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTHYR5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 13:57:48 -0400
Received: from aneto.able.es ([212.97.163.22]:30718 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262055AbTHYR5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 13:57:31 -0400
Date: Mon, 25 Aug 2003 19:57:28 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>,
       johnstul@us.ibm.com, jamesclv@us.ibm.com
Subject: Re: [PATCH] add seq_file "single" interfaces
Message-ID: <20030825175728.GA2199@werewolf.able.es>
References: <20030825100310.3c96fd68.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030825100310.3c96fd68.rddunlap@osdl.org>; from rddunlap@osdl.org on Mon, Aug 25, 2003 at 19:03:10 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.25, Randy.Dunlap wrote:
> Hi,
> 
> This patch adds the seq_file "single" interfaces from 2.6.0-test4
> to 2.4.22++.  This will enable larger /proc/interrupts and
> /proc/mdstat, which currently have some oopsing problems
> with large outputs.
> 
> Please apply.
> 

How about exporting them in kernel/ksyms ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-rc3-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
