Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWG2TI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWG2TI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWG2TI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:08:27 -0400
Received: from ns.suse.de ([195.135.220.2]:1236 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751416AbWG2TI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:08:26 -0400
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
Date: Sat, 29 Jul 2006 21:04:18 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <200607292050.37877.ak@suse.de> <20060729185737.GG26963@stusta.de>
In-Reply-To: <20060729185737.GG26963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607292104.18030.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > It should be obsolete with autoprobing for the feature as earlier discussed.
> 
> That's not the point of the version information in the help text.

The point in the current option is to select or not select it - 
if the user gets it wrong it won't compile or worse miscompile.

Once it is auto selected the user could be still informed about 
it, but it doesn't matter much anymore (we don't inform the user
about every possible trade off based on compiler version everywhere)

-Andi
