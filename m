Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbTDRSM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 14:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263194AbTDRSM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 14:12:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6839 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263191AbTDRSM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 14:12:26 -0400
Date: Fri, 18 Apr 2003 11:24:19 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Nico Schottelius <schottelius@wdt.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unloading bridge fails [2.5.67]
Message-Id: <20030418112419.3661f5f3.shemminger@osdl.org>
In-Reply-To: <20030417093432.GB266@schottelius.org>
References: <20030417093432.GB266@schottelius.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003 11:34:32 +0200
Nico Schottelius <schottelius@wdt.de> wrote:

> Hello!
> 
> Using plain 2.5.67:
> 
> flapp:~ # brctl addbr br0
> flapp:~ # brctl addif br0 eth0
> flapp:~ # ifconfig br0 23.23.23.23 up
> flapp:~ # brctl delif br0 eth0
> flapp:~ # ifconfig br0 down
> 
> until here it works fine, but now
> 
> flapp:~ # brctl delbr br0
> 
> simply hangs. 
> 


I submitted several patches that have been accepted  that
address this and several other management API issues. Your short set of
commands works fine now.

Do you need the patches for 2.5.67 right now, or can you wait till they
come out in 2.5.68?
