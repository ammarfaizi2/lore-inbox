Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVL1UfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVL1UfK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 15:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVL1UfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 15:35:10 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:28836 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S964898AbVL1UfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 15:35:09 -0500
X-IronPort-AV: i="3.99,304,1131350400"; 
   d="scan'208"; a="384741488:sNHT29099812"
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-tiny@selenic.com
Subject: Re: [PATCH] Make vm86 support optional
X-Message-Flag: Warning: May contain useful information
References: <20051228202735.GU3356@waste.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 28 Dec 2005 12:35:00 -0800
In-Reply-To: <20051228202735.GU3356@waste.org> (Matt Mackall's message of
 "Wed, 28 Dec 2005 14:27:35 -0600")
Message-ID: <ada64p9arkb.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Dec 2005 20:35:07.0419 (UTC) FILETIME=[30B8FEB0:01C60BEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +          This option is required by programs like DOSEMU to run 16-bit legacy
 > +	  code on X86 processors. It also may be needed by software like
 > +          XFree86 to initialize some video cards via BIOS. Disabling this
 > +          option saves about 6k.

I'm not sure if this is even worth pointing out, but there's a
whitespace inconsistency here.

 - R. [obviously with too little to do on a slow vacation day]
