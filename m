Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161343AbWHDT1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161343AbWHDT1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161353AbWHDT1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:27:05 -0400
Received: from mga07.intel.com ([143.182.124.22]:56707 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161343AbWHDT1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:27:03 -0400
X-IronPort-AV: i="4.07,212,1151910000"; 
   d="scan'208"; a="97908503:sNHT3190537385"
Message-ID: <44D39F73.8000803@linux.intel.com>
Date: Fri, 04 Aug 2006 12:26:43 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Antonio Vargas <windenntw@gmail.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>  <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>  <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org>  <1154667875.11382.37.camel@localhost.localdomain>  <20060803225357.e9ab5de1.akpm@osdl.org>  <1154675100.11382.47.camel@localhost.localdomain>  <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz> <69304d110608041146t44077033j9a10ae6aee19a16d@mail.gmail.com> <Pine.LNX.4.63.0608041150360.18862@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0608041150360.18862@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> I'm not commenting on any of the specifics of the interface calls (I 
> trust you guys to make that be sane :-) I'm just responding the the idea 
> that the interface actually needs to be locked down to an ABI as opposed 
> to just source-level compatability.

you are right that the interface to the HV should be stable. But those are going
to be specific to the HV, the paravirt_ops allows the kernel to smoothly deal
with having different HV's.
So in a way it's an API interface to allow the kernel to deal with multiple
different ABIs that exist today and will in the future.
