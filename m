Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143420AbREKX2a>; Fri, 11 May 2001 19:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143422AbREKX2U>; Fri, 11 May 2001 19:28:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58780 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S143420AbREKX2K>;
	Fri, 11 May 2001 19:28:10 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15100.30085.5209.499946@pizda.ninka.net>
Date: Fri, 11 May 2001 16:28:05 -0700 (PDT)
To: "H . J . Lu" <hjl@lucon.org>
Cc: alan@lxorguk.ukuu.org.uk, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
In-Reply-To: <20010511162412.A11896@lucon.org>
In-Reply-To: <20010511162412.A11896@lucon.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


H . J . Lu writes:
 > 2.4.4-ac8 disables IP auto config by default even if CONFIG_IP_PNP is
 > defined.  Here is a patch.

It doesn't make any sense to enable this unless parameters are
given to the kernel via the kernel command line or from firmware
settings.

Later,
David S. Miller
davem@redhat.com
