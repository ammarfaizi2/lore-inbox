Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbTFFWT4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 18:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTFFWT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 18:19:56 -0400
Received: from aneto.able.es ([212.97.163.22]:41882 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262320AbTFFWTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 18:19:55 -0400
Date: Sat, 7 Jun 2003 00:33:27 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Cc: Daniel Sheltraw <sheltraw@unm.edu>
Subject: Re: mkinitrd failed
Message-ID: <20030606223327.GC4764@werewolf.able.es>
References: <1054938590.3ee115deead1e@webdjn.unm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1054938590.3ee115deead1e@webdjn.unm.edu>; from sheltraw@unm.edu on Sat, Jun 07, 2003 at 00:29:50 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.07, Daniel Sheltraw wrote:
> Hello list
> 
> I am rebuilding a 2.4.20 kernel on a RedHat9 system. After doing
> 
> make dep
> make bzImage
> make install
> 
> I get an error that mkinitrd has failed. The "RAM disk support" 
> and "Init Ram disk" sections of xconfig have been enabled. ANy ideas?
> 

You don't have built/installed modules. Try this sequence:

make dep bzImage modules modules_install install

Hope this helps.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc7-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
