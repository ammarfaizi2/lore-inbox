Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262584AbREZXDG>; Sat, 26 May 2001 19:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbREZXBs>; Sat, 26 May 2001 19:01:48 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262583AbREZXA0>;
	Sat, 26 May 2001 19:00:26 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15119.56639.163937.257003@pizda.ninka.net>
Date: Sat, 26 May 2001 09:43:43 -0700 (PDT)
To: Dave Gilbert <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5: Duplicate PCI devices
In-Reply-To: <Pine.LNX.4.10.10105261728200.750-100000@tardis.home.dave>
In-Reply-To: <Pine.LNX.4.10.10105261728200.750-100000@tardis.home.dave>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave Gilbert writes:
 > /proc/pci seems to be only listing it once.

lspci uses /prov/bus/pci/${BUS}/${DEVICE}
so likely it is showing up twice there.

Later,
David S. Miller
davem@redhat.com
