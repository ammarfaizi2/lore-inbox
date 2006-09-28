Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751951AbWI1RIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbWI1RIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbWI1RIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:08:48 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:46801 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751951AbWI1RIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:08:48 -0400
Date: Thu, 28 Sep 2006 19:08:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Shu-Ming <m943010036@student.nsysu.edu.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The structure of __ksymtab and __ksymtab_gpl?
Message-ID: <20060928170836.GB29691@uranus.ravnborg.org>
References: <000301c6e303$72a12bd0$8f9c758c@shuming>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301c6e303$72a12bd0$8f9c758c@shuming>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 09:38:56PM +0800, Shu-Ming wrote:
> Hi all
> 
> What is the the structure of __ksymtab and __ksymtab_gpl ?
> I mean that __ksymtab and __ksymtab_gpl are the section headers of ELF 
> format.
> 
> And how to index to the __ksymtab_strings section header from __ksymtab & 
> __ksymtab_gpl ?

I suggest you take a deep look at scripts/mod/modpost.c - that should help you.
I do not recall the details by heart but modpost.c is a heavy user
so it should be rather simple to dechiper it from there.

	Sam
