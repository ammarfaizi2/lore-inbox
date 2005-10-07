Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030548AbVJGTqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030548AbVJGTqr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 15:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030549AbVJGTqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 15:46:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:13533 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030548AbVJGTqq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 15:46:46 -0400
Date: Fri, 7 Oct 2005 14:46:44 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] ppc64: EEH typos, include files, macros, whitespace
Message-ID: <20051007194644.GA29826@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com> <20050930005141.GA6173@austin.ibm.com> <17219.46319.501091.93202@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17219.46319.501091.93202@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 09:11:43PM +1000, Paul Mackerras was heard to remark:
> 
> This makes the line go over 80 columns, which seems unnecessary.

Hm, I code with tabstops set to 3, on a 132-column terminal. 
It looked goofy there.

> > - * @token i/o token, should be address in the form 0xE....
> > + * @token i/o token, should be address in the form 0xA....
> 
> I think the virtual addresses we get from ioremap these days start
> with 0xD00008...

Ah, didn't realize this changed. I was simultaneously debugging
a 2.4 kernel (for other reasons) when I noticed this.  

--linas
