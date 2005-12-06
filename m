Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVLFTbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVLFTbj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbVLFTbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:31:38 -0500
Received: from web34113.mail.mud.yahoo.com ([66.163.178.111]:10837 "HELO
	web34113.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030203AbVLFTbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:31:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HRtytWnMOSXZx/GSLPj3nmrf/6owBMewEQAmB7zIDQ6u9P09f8Z8VdmpNjGN3cQbqcCFMwwVOtevVReo9unlUcWnyiukVpSiVF2L2aqdVVbukOFREiUXe75Wiwep682KQShwkjJk3JjBG0+7+tZ+DMVKqJeHucIc2oYOrRjbO8A=  ;
Message-ID: <20051206193137.75909.qmail@web34113.mail.mud.yahoo.com>
Date: Tue, 6 Dec 2005 11:31:37 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: nfs unhappiness with memory pressure
To: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051206143641.3feadaea.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >  ...OTOH, I'm not entirely sure we want to use GFP_ATOMIC and risk
> >  bleeding the emergency pools dry: we also need those in order to receive
> >  replies from the server.
> 
> You can use (GFP_ATOMIC & ~__GFP_HIGH) to avoid draining emergency pools.
> 
> 

After beating on this for a while now, it all seems very happy.  The write out to nfs are a little
choppy, but make forward progress.

Any chance of this being in 2.6.15?

-Kenny



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

