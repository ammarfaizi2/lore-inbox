Return-Path: <linux-kernel-owner+w=401wt.eu-S932158AbWLLJKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWLLJKw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 04:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWLLJKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 04:10:52 -0500
Received: from cantor2.suse.de ([195.135.220.15]:49754 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932158AbWLLJKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 04:10:51 -0500
Message-ID: <457E7215.3010707@suse.de>
Date: Tue, 12 Dec 2006 10:10:45 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Cc: paulus@samba.org, torvalds@osdl.org, olaf@aepfle.de, herbert@13thfloor.at,
       apw@shadowen.org, ak@suse.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org, drfickle@us.ibm.com,
       linuxppc-dev@ozlabs.org
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
References: <20061211185536.GA19338@aepfle.de>	<Pine.LNX.4.64.0612111106310.12500@woody.osdl.org>	<17789.54777.283849.950002@cargo.ozlabs.ibm.com> <20061211.160541.111202759.davem@davemloft.net>
In-Reply-To: <20061211.160541.111202759.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> That only gives you the version, not the whole version string, but you
> could put the whole string in such a location when adding such a
> facility to powerpc if you wanted to.

Hmm, as we have those fancy ELFNOTE macros now, can't we just the
version string into one?

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
