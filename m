Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161385AbWHDTws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161385AbWHDTws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161386AbWHDTws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:52:48 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:65532 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1161385AbWHDTwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:52:47 -0400
Date: Fri, 4 Aug 2006 12:49:13 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jeff Dike <jdike@addtoit.com>
cc: Antonio Vargas <windenntw@gmail.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
In-Reply-To: <20060804194549.GA5897@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.63.0608041246010.18862@qynat.qvtvafvgr.pbz>
References: <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
  <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org> 
 <1154667875.11382.37.camel@localhost.localdomain>  <20060803225357.e9ab5de1.akpm@osdl.org>
  <1154675100.11382.47.camel@localhost.localdomain> 
 <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz> 
 <69304d110608041146t44077033j9a10ae6aee19a16d@mail.gmail.com> 
 <Pine.LNX.4.63.0608041150360.18862@qynat.qvtvafvgr.pbz>
 <20060804194549.GA5897@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006, Jeff Dike wrote:

> On Fri, Aug 04, 2006 at 12:06:28PM -0700, David Lang wrote:
>> I understand this, but for example a UML 2.6.10 kernel will continue to run
>> unmodified on top of a 2.6.17 kernel, the ABI used is stable. however if
>> you have a 2.6.10 host with a 2.6.10 UML guest and want to run a 2.6.17
>> guest you may (but not nessasarily must) have to upgrade the host to 2.6.17
>> or later.
>
> Why might you have to do that?

take this with a grain of salt, I'm not saying the particular versions I'm 
listing would require this

if your new guest kernel wants to use some new feature (SKAS3, time 
virtualization, etc) but the older host kernel didn't support some system call 
nessasary to implement it, you may need to upgrade the host kernel to one that 
provides the new features.

David Lang
