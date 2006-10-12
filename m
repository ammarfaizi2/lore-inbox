Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWJLVLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWJLVLm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWJLVLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:11:42 -0400
Received: from mail.corp.idt.net ([169.132.25.53]:30984 "EHLO
	mail.corp.idt.net") by vger.kernel.org with ESMTP id S1750927AbWJLVLm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:11:42 -0400
Message-ID: <452EAF8D.9040405@hq.idt.net>
Date: Thu, 12 Oct 2006 17:11:41 -0400
From: Serge Aleynikov <serge@hq.idt.net>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@redhat.com>
Subject: Re: non-critical security bug fix
References: <452D3ED9.509@hq.idt.net> <20061012190647.GA6725@sergelap.austin.ibm.com> <452E96C5.8070307@hq.idt.net> <20061012202926.GA5690@sergelap.austin.ibm.com>
In-Reply-To: <20061012202926.GA5690@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Are you able to modify the source of the application you bought?  If so,
> you can trivially fix it to do what you need by doing a cap_set_proc
> after the suid as I described before, i.e.
> 
> 	ret = setuid();
> 	caps = cap_from_text("cap_net_raw=e");
> 	ret = cap_set_proc(caps);
> 
> Is that an option?

Unfortunately that product doesn't come with sources.  :-(

-- 
Serge Aleynikov
Routing R&D, IDT Telecom
Tel: +1 (973) 438-3436
Fax: +1 (973) 438-1464
