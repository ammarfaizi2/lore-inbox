Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUDHTjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUDHTjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:39:13 -0400
Received: from mail.cyclades.com ([64.186.161.6]:3250 "EHLO intra.cyclades.com")
	by vger.kernel.org with ESMTP id S262368AbUDHTjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:39:12 -0400
Date: Thu, 8 Apr 2004 16:11:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Linux 2.4.26-rc2
Message-ID: <20040408191109.GA15888@logos.cnet>
References: <20040406004251.GA24918@logos.cnet> <16498.3704.252459.691039@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16498.3704.252459.691039@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 11:57:12AM +1000, Paul Mackerras wrote:
> Marcelo,
> 
> Any chance of getting this patch in before 2.4.26 final?
> 
> This patch is needed for compiling 2.4 with recent versions of gcc,
> such as the gcc 3.3.3 hammer branch or gcc 3.4.  The gcc developers
> changed the name of the attribute that indicates that something is
> actually needed, even though gcc can't see why, from "__unused__" to
> "__used__".  This patch copes with that.
> 
> The patch is from Stephen Rothwell.  He discovered the problem on
> ppc64, but in fact it would exist on any architecture.

Applied, 

thanks!
