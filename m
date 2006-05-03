Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbWECCqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWECCqY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 22:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWECCqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 22:46:24 -0400
Received: from ozlabs.org ([203.10.76.45]:19408 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965073AbWECCqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 22:46:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17496.6519.733076.663815@cargo.ozlabs.ibm.com>
Date: Wed, 3 May 2006 12:46:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
In-Reply-To: <801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org>
References: <20060429232812.825714000@localhost.localdomain>
	<200605020150.14152.arnd@arndb.de>
	<1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org>
	<200605021259.24157.arnd@arndb.de>
	<801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool writes:

> > Well, it could run on other platforms, except:
> >
> > - it requires a few properties in the device tree (local-mac-address,
> >   firmware), so it should also depend on PPC
> 
> The portions of code that require OF should have appropriate #ifdef  
> guards.

So you're suggesting that we change the Makefile so we can *add*
ifdefs?  Usually we do it the other way around. :)

Paul.
