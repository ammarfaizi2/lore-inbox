Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWHaIPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWHaIPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWHaIPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:15:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:50157 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751299AbWHaIPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:15:38 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 5/8] Fix places where using %gs changes the usermode ABI.
Date: Thu, 31 Aug 2006 10:13:03 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <20060830235201.106319215@goop.org> <200608310936.36772.ak@suse.de> <44F69815.4070105@goop.org>
In-Reply-To: <44F69815.4070105@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311013.03164.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 10:04, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > On Thursday 31 August 2006 09:22, Jeremy Fitzhardinge wrote:
> >   
> >> Andi Kleen wrote:
> >>     
> >>> [...] So did you check that ESP, EIP, EFLAGS now come out correctly again? 
> >>> (e.g. do gdb and strace still work?)
> >>>   
> >>>       
> >> Yep.
> >>     
> >
> > Ok it looks good then. I would apply it, but it seems to require the paravirt
> > patchkit first?
> 
> No, it's against -rc4-mm3.  How much does it conflict with your tree?

The first entry.S patch already threw 4 rejects or so.  I didn't try
further. I guess I'll take it together with the rest of the paravirt
stuff after the .19 merge.

-Andi

