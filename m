Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263348AbUD2GUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbUD2GUf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUD2GUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:20:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:19074 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263348AbUD2GUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:20:33 -0400
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <16528.28485.996662.598051@cargo.ozlabs.ibm.com>
References: <409021D3.4060305@fastclick.com>
	 <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com>
	 <40905127.3000001@fastclick.com> <20040428180038.73a38683.akpm@osdl.org>
	 <16528.23219.17557.608276@cargo.ozlabs.ibm.com>
	 <20040428185342.0f61ed48.akpm@osdl.org>
	 <20040428194039.4b1f5d40.akpm@osdl.org>
	 <16528.28485.996662.598051@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1083219158.20089.128.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 16:12:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The really strange thing is that the behaviour seems to get worse the
> more RAM you have.  I haven't noticed any problem at all on my laptop
> with 768MB, only on the G5, which has 2.5GB.  (The laptop is still on
> 2.6.2-rc3 though, so I will try a newer kernel on it.)

Your G5 also has a 2Gb IO hole in the middle of zone DMA, it's possible
that the accounting doesn't work properly.

Ben.


