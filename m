Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135916AbRD0IC6>; Fri, 27 Apr 2001 04:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135922AbRD0ICt>; Fri, 27 Apr 2001 04:02:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2976 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135916AbRD0ICc>;
	Fri, 27 Apr 2001 04:02:32 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15081.10132.61529.136589@pizda.ninka.net>
Date: Fri, 27 Apr 2001 01:02:28 -0700 (PDT)
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-pre7 build failure w/ IP NAT and ipchains
In-Reply-To: <20010427025315.A25473@burns.dt.e-technik.uni-dortmund.de>
In-Reply-To: <20010427025315.A25473@burns.dt.e-technik.uni-dortmund.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Your configuration seems impossible, somehow the config system allowed
you to set CONFIG_IP_NF_COMPAT_IPCHAINS without setting
CONFIG_IP_NF_CONNTRACK.

Later,
David S. Miller
davem@redhat.com
