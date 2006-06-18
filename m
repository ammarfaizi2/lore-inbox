Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWFRI7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWFRI7z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 04:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWFRI7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 04:59:55 -0400
Received: from ns1.suse.de ([195.135.220.2]:47074 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932172AbWFRI7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 04:59:54 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.16-rc6-mm2] x86: add NUMA to oops messages
Date: Sun, 18 Jun 2006 10:59:44 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>
References: <200606180415_MC3-1-C2C5-AF7A@compuserve.com>
In-Reply-To: <200606180415_MC3-1-C2C5-AF7A@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606181059.44576.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 June 2006 10:13, Chuck Ebbert wrote:
> Add "NUMA" to x86 oops printouts to help with debugging.  Use vermagic.h
> defines to clean up the code, suggested by Arjan van de Ven.

I don't see any particular value in printing NUMA here,
and putting half of .config into the oops doesn't seem
like a good long term strategy.

-Andi

  
