Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWHRQVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWHRQVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWHRQVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:21:52 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:25006 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751408AbWHRQVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:21:52 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/13] IB/ehca: includes
Date: Fri, 18 Aug 2006 18:21:49 +0200
User-Agent: KMail/1.9.1
Cc: Christoph Raisch <RAISCH@de.ibm.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
       Marcus Eder <MEDER@de.ibm.com>
References: <OFED0915E4.3CED6795-ONC12571CE.0053ECB8-C12571CE.0055546A@de.ibm.com>
In-Reply-To: <OFED0915E4.3CED6795-ONC12571CE.0053ECB8-C12571CE.0055546A@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181821.49961.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 August 2006 17:35, Christoph Raisch wrote:
> we'll change these EDEBs to a wrapper around dev_err, dev_dbg and dev_warn
> as it's done in the mthca driver.
>
> ...
>
> Hope that's the "official" way how to implement it in ib drivers.

I guess it would be even better to just use the dev_* macros directly
instead of having your own wrapper. You can do that in both ehca and ehea.

	Arnd <><
