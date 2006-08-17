Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWHQKtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWHQKtE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 06:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWHQKtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 06:49:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:488 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932437AbWHQKtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 06:49:01 -0400
Subject: RE: Relation between free() and remove_vm_struct()
From: Arjan van de Ven <arjan@infradead.org>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: kernelnewbies@nl.linux.org, linux-newbie@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMKEEMDGAA.abum@aftek.com>
References: <BKEKJNIHLJDCFGDBOHGMKEEMDGAA.abum@aftek.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 17 Aug 2006 12:48:36 +0200
Message-Id: <1155811716.4494.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 13:26 +0530, Abu M. Muttalib wrote:
> Hi Arjan,
> 
> Thnax for your reply.
> 
> > second of all, glibc delays freeing of some memory (in the brk() area)
> > to optimize for cases of frequent malloc/free operations, so that it
> > doesn't have to go to the kernel all the time (and a free would imply a
> > cross cpu TLB invalidate which is *expensive*, so batching those up is a
> > really good thing for performance)
> 
> As per my observation, in two scenarios that I have tried, in one scenario I
> am able to see the prints from remove_vm_struct(), but in the other
> scenario, I don't see any prints from remove_vm_strcut().
> 
> My question is, if there is delayed freeing of virtual address space, it
> should be the same in both the scenarios, but its not the case, and this
> behavior is consistent for my two scenarios, i.e.. in one I am able to see
> the kernel prints and in other I am not, respectively.

I'm sorry but you're not providing enough information for me to
understand your follow-on question.

Greetings,
   Arjan van de Ven

> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

