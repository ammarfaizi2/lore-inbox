Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbTGINmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 09:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268256AbTGINmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 09:42:44 -0400
Received: from fep4.012.net.il ([212.117.129.203]:1155 "EHLO fep4.012.net.il")
	by vger.kernel.org with ESMTP id S266025AbTGINml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 09:42:41 -0400
Message-ID: <55493.81.218.217.119.1057759037.squirrel@idanso.dyndns.org>
In-Reply-To: <20030708112048.2c3b680d.akpm@osdl.org>
References: <40390000.1057673479@[10.10.2.4]> 
     <20030708112048.2c3b680d.akpm@osdl.org>
Date: Wed, 9 Jul 2003 16:57:17 +0300 (IDT)
Subject: Re: [Bug 890] New: performance regression compared to 2.4.20 
     undertight RAM conditions
From: "Idan Sofer" <idan@idanso.dyndns.org>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The 2.4 VM's virtual scan has the effect of swapping out one process at a
> time.  2.5's physical(ish) scan doesn't have that side-effect.
Can you elaborate on the matter of virtual vs physical VM scan? Am I
correct concluding this has to do with rmap?
> To fix this properly we need load control: to identify when the system is
> thrashing and to explicitly suspend chosen processes for a while, so other
> processes can make decent progress.  A couple of people are looking at
> that; I'm not sure what stage it is at.
If there is even an experimental patch then I will be happy to try it out,
it's probably has a lesser effect when you enough ram, but currently
that's the reason I still avoid using development kernels on that box.


-- 
Idan
