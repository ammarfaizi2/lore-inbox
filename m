Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935732AbWK1QX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935732AbWK1QX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 11:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935748AbWK1QX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 11:23:28 -0500
Received: from cantor.suse.de ([195.135.220.2]:22185 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S935732AbWK1QX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 11:23:27 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH] work around gcc4 issue with -Os in Dwarf2 stack unwind code
Date: Tue, 28 Nov 2006 17:23:23 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <456C51D8.76E4.0078.0@novell.com>
In-Reply-To: <456C51D8.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611281723.23594.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 November 2006 15:12, Jan Beulich wrote:
> This fixes a problem with gcc4 mis-compiling the stack unwind code under
> -Os, which resulted in 'stuck' messages whenever an assembly routine was
> encountered.
> 
> (The second hunk is trivial cleanup.)

Thanks for finally nailing that bug.

-Andi
