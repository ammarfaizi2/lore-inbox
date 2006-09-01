Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWIAO6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWIAO6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 10:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWIAO6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 10:58:49 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:24984 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750881AbWIAO6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 10:58:48 -0400
Subject: Re: [patch 4/9] Guest page hinting: volatile swap cache.
From: Dave Hansen <haveblue@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
In-Reply-To: <20060901111006.GE15684@skybase>
References: <20060901111006.GE15684@skybase>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 07:58:33 -0700
Message-Id: <1157122713.28577.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 13:10 +0200, Martin Schwidefsky wrote:
> +#if defined(CONFIG_PAGE_STATES)

This is a bit odd.  Why not use an #ifdef like the rest of the kernel?
 
-- Dave

