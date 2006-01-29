Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWA2IF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWA2IF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 03:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWA2IF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 03:05:56 -0500
Received: from smtpout.mac.com ([17.250.248.70]:14568 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750743AbWA2IF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 03:05:56 -0500
In-Reply-To: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <58DCA4AE-8AD5-4AED-A274-EB2017B9617A@mac.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 0/5] Task references..
Date: Sun, 29 Jan 2006 03:05:17 -0500
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 29, 2006, at 02:19, Eric W. Biederman wrote:
> In the pid virtualization thread it was noticed that currently in  
> the kernel we have a variables that hold pids of processes or  
> process groups that we later intend to send signals to.
>
> It was suggest that we instead use pointers to struct task_struct  
> and reference count them to get around this problem.

Very nice!  I like the way you did this!  I didn't have time to go  
over it in much detail, but I approve of the general idea.  Thanks!

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that would also stop them from doing clever things.
   -- Doug Gwyn


