Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbVENR4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVENR4j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 13:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbVENR4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 13:56:39 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18118 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262815AbVENR4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 13:56:38 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Matt Mackall <mpm@selenic.com>, Andy Isaacson <adi@hexapodia.org>,
       Andi Kleen <ak@muc.de>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <1116089068.6007.13.camel@laptopd505.fenrus.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	 <20050513215905.GY5914@waste.org>
	 <1116024419.20646.41.camel@localhost.localdomain>
	 <1116025212.6380.50.camel@mindpipe>  <20050513232708.GC13846@redhat.com>
	 <1116027488.6380.55.camel@mindpipe>
	 <1116084186.20545.47.camel@localhost.localdomain>
	 <1116088229.8880.7.camel@mindpipe>
	 <1116089068.6007.13.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 14 May 2005 13:56:36 -0400
Message-Id: <1116093396.9141.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-14 at 18:44 +0200, Arjan van de Ven wrote:
> then JACK is terminally broken if it doesn't have a fallback for non-
> rdtsc cpus. 

It does have a fallback, but the selection is done at compile time.  It
uses rdtsc for all x86 CPUs except pre-i586 SMP systems.

Maybe we should check at runtime, but this has always worked.

Lee

