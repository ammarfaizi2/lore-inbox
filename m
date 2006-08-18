Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWHROU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWHROU7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbWHROU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:20:59 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:40151 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030421AbWHROU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:20:58 -0400
In-Reply-To: <200608181547.47081.arnd.bergmann@de.ibm.com>
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
To: abergman@de.ibm.com
Cc: Arjan van de Ven <arjan@infradead.org>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
       Marcus Eder <meder@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       Thomas Q Klein <tklein@de.ibm.com>, tklein@linux.ibm.com
X-Mailer: Lotus Notes Release 7.0 HF242 April 21, 2006
Message-ID: <OFC184057C.C58732A2-ONC12571CE.004E5EF6-C12571CE.004ED1D4@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 18 Aug 2006 16:24:48 +0200
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 18/08/2006 16:24:49
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You should really do some measurements to see what the minimal
> queue sizes are that can get you optimal throughput.
>
>    Arnd <><

we did.
And as always in performance tuning... one size fits all unfortunately is
not the correct answer.
Therefore we'll leave that open to the user as most other new ethernet
driver did as well.

Regards . . . Christoph R

