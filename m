Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWFWMdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWFWMdK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWFWMdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:33:10 -0400
Received: from mail.suse.de ([195.135.220.2]:4515 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932560AbWFWMdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:33:08 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86_64: enlarge window for stack growth
Date: Fri, 23 Jun 2006 14:29:58 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200606222035_MC3-1-C33B-4A7F@compuserve.com>
In-Reply-To: <200606222035_MC3-1-C33B-4A7F@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606231429.58792.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 June 2006 02:33, Chuck Ebbert wrote:
> Allow stack growth so the 'enter' instruction works.  Also
> fixes problem in compat_sys_kexec_load() which could allocate
> more than 128 bytes using compat_alloc_user_space().

Merged thanks.

-Andi
