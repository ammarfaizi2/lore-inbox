Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWCWR6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWCWR6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWCWR6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:58:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48850 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964917AbWCWR6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:58:34 -0500
Date: Thu, 23 Mar 2006 12:58:22 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1
Message-ID: <20060323175822.GA7816@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060323014046.2ca1d9df.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323014046.2ca1d9df.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 01:40:46AM -0800, Andrew Morton wrote:

 > - Be aware that someone-who-doesn't-know-about-allmodconfig has screwed up
 >   AGP on x86_64: if your link fails with various missing AGP symbols you'll
 >   need to set the various CONFIG_AGP* symbols to `y' rather than `m'.  Then
 >   work out which other Kconfig rule keeps on flipping them back to `m' again,
 >   then fix that too.

I haven't merged anything into agpgart-git for a week or two, so it's
more than likely..

 > +x86_64-mm-via-agp.patch
 > +x86_64-mm-sis-agp.patch
 > 
 >  x86_64 tree updates


whatever these are.

		Dave

-- 
http://www.codemonkey.org.uk
