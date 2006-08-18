Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWHRQQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWHRQQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWHRQQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:16:57 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:9900 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751106AbWHRQQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:16:56 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
Date: Fri, 18 Aug 2006 18:16:51 +0200
User-Agent: KMail/1.9.1
Cc: Christoph Raisch <RAISCH@de.ibm.com>, abergman@de.ibm.com,
       Thomas Q Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, tklein@linux.ibm.com,
       Arjan van de Ven <arjan@infradead.org>
References: <OFC184057C.C58732A2-ONC12571CE.004E5EF6-C12571CE.004ED1D4@de.ibm.com>
In-Reply-To: <OFC184057C.C58732A2-ONC12571CE.004E5EF6-C12571CE.004ED1D4@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181816.52079.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 August 2006 16:24, Christoph Raisch wrote:
> And as always in performance tuning... one size fits all unfortunately is
> not the correct answer.

Ah, good. What is the maximum sensible value that you came up with?

> Therefore we'll leave that open to the user as most other new ethernet
> driver did as well.

Sure. The interesting question is whether you want to allow users
to set it to a value that is no longer sensible to do with
__get_free_pages() and requires vmalloc().

	Arnd <><
