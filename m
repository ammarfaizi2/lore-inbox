Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265238AbUFWJ4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUFWJ4Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 05:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUFWJ4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 05:56:23 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:15239 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S265238AbUFWJ4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 05:56:19 -0400
Date: Wed, 23 Jun 2004 11:56:17 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2 udp multicast problem (sendto hangs)
Message-Id: <20040623115617.68b93100@phoebee>
In-Reply-To: <20040622164000.110f2a63@phoebee>
References: <20040622164000.110f2a63@phoebee>
X-Mailer: Sylpheed-Claws 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.2 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if I use MSG_DONTWAIT with sendto, I get temporarily unavailable resources
(many!):

sendto(sendfd): Resource temporarily unavailable

but isn't udp supposed to not block?

Martin

-- 
MyExcuse:
astropneumatic oscillations in the water-cooling

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>
