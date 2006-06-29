Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWF2JLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWF2JLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWF2JLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:11:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:39913 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751369AbWF2JLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:11:04 -0400
Subject: Re: Please pull from 'for_paulus' branch of powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Zhang Wei-r63237 <Wei.Zhang@freescale.com>, linuxppc-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <BDF5A6D5-E7F4-4CDF-9B34-13A66A0B7C99@kernel.crashing.org>
References: <9FCDBA58F226D911B202000BDBAD467306E19B76@zch01exm40.ap.freescale.net>
	 <BDF5A6D5-E7F4-4CDF-9B34-13A66A0B7C99@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 19:10:52 +1000
Message-Id: <1151572252.28229.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Even though other 86xx platforms have no these PCI chips, these  
> > codes will not take effect.
> 
> Its code bloat for systems that dont need it.

Well... it depends :) If it's totally unlikely to ever have this chip in
those platforms, then yes. But if it's common enough, it's fair to have
the quirk in a generic place (provided that Whang is right and the fixup
is indeed the same for all 86xx platforms)

Ben.


