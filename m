Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423711AbWJaR2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423711AbWJaR2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423706AbWJaR2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:28:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:22171 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423711AbWJaR2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:28:54 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: 2.6.19-rc3: more DWARFs and strange messages
Date: Tue, 31 Oct 2006 18:28:52 +0100
User-Agent: KMail/1.9.5
Cc: "Martin Lorenz" <martin@lorenz.eu.org>, linux-kernel@vger.kernel.org
References: <20061028200151.GC5619@gimli> <20061031160815.GM27390@gimli> <454787AB.76E4.0078.0@novell.com>
In-Reply-To: <454787AB.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610311828.52980.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 17:28, Jan Beulich wrote:
> Can you perhaps get us arch/i386/kernel/{entry,process}.o,
> .config, and (assuming you can reproduce the original problem)
> the raw stack dump obtained with a sufficiently high kstack=
> option?

WARN_ON unfortunately doesn't dump the raw stack at all (maybe that
should be fixed) 

-Andi
