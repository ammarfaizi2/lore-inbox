Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVLBCq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVLBCq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVLBCq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:46:29 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:13018 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964797AbVLBCq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:46:28 -0500
Message-ID: <438FB582.3090002@bigpond.net.au>
Date: Fri, 02 Dec 2005 13:46:26 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, sam@ravnborg.org
Subject: Re: [q] make modules_install as non-root?
References: <2cd57c900512011823v153a6763t@mail.gmail.com>
In-Reply-To: <2cd57c900512011823v153a6763t@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 2 Dec 2005 02:46:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> Hello people,
> 
> I wrote my own installkernel so I can do `make install' as non-root
> with the help of sudo. But how can we get to do `make modules_install'
> as non-root with sudo as well?
> 
> The works of modules_install seem scattered over several places.  Is
> it a nice idea to factor out an *installmodules* script for `make
> modules_install' to invoke?
> 
> ps:
> Linus recommend us to build as non-root and install as root.
> I ask if we should install as non-root too.

Personally, I just use "sudo make install" or "sudo make 
modules_install" to do installations as an ordinary user.  No need for 
special scripts or modifications to the build procedure.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
