Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWHXRPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWHXRPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWHXRPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:15:51 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41351 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030401AbWHXRPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:15:50 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: devel@laptop.org
Subject: Re: [OLPC-devel] Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
Date: Thu, 24 Aug 2006 19:15:46 +0200
User-Agent: KMail/1.9.1
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       David Woodhouse <dwmw2@infradead.org>, linux-tiny@selenic.com,
       linux-kernel@vger.kernel.org
References: <1156429585.3012.58.camel@pmac.infradead.org> <1156433068.3012.115.camel@pmac.infradead.org> <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608241915.47451.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 August 2006 18:48, Jan Engelhardt wrote:
> If visibility supports had been in GCC a long time ago, I am sure we would 
> not need EXPORT_SYMBOL today, or rather, would do it by use of 
> __attribute__() rather than a macro that ksymtabs it. Or am I possibly 
> misunderstanding something?
> 
It's probably true, but the way it's done today gave us CONFIG_MODVERSIONS
and EXPORT_SYMBOL_GPL, which would break when turning EXPORT_SYMBOL into a
simple __attribute__().

	Arnd <><
