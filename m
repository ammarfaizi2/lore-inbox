Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTJ3Xui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTJ3Xui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:50:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:60560 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262942AbTJ3Xuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:50:37 -0500
Date: Thu, 30 Oct 2003 15:48:25 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Shaun Savage <savages@savages.net>
Cc: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: kernel modules won't auto load
Message-Id: <20031030154825.70b13a35.rddunlap@osdl.org>
In-Reply-To: <3FA19A2A.3090500@savages.net>
References: <3FA19A2A.3090500@savages.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003 15:09:30 -0800 Shaun Savage <savages@savages.net> wrote:

| I am trying to get kernel 2.6-t9 working on redhat9
| 
| I have downloaded and compiled, and installed the kernel.
| module-init-tools-0.9.15-pre2,
| and iptables-1.2.9rc1
| 
| when I run iptables-restore it dies if I have not loaded the kernel
| modules by hand before.

Did you run generate-modprobe.con (script) to convert your
/etc/modules.conf file to /etc/modprobe.conf ?

--
~Randy
