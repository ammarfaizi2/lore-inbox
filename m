Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131364AbRCPVrg>; Fri, 16 Mar 2001 16:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131409AbRCPVrQ>; Fri, 16 Mar 2001 16:47:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35215 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131364AbRCPVrP>;
	Fri, 16 Mar 2001 16:47:15 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15026.35239.183740.108104@pizda.ninka.net>
Date: Fri, 16 Mar 2001 13:46:15 -0800 (PST)
To: "Mathieu Giguere (LMC)" <lmcmgig@lmc.ericsson.se>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Claude LeFrancois (LMC)" <lmcclef@lmc.ericsson.se>
Subject: RE: UDP stop transmitting packets!!!
In-Reply-To: <7E67DE81C0B6D311B30500805FFEBAAE03078E3F@lmc35.lmc.ericsson.se>
In-Reply-To: <7E67DE81C0B6D311B30500805FFEBAAE03078E3F@lmc35.lmc.ericsson.se>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mathieu Giguere (LMC) writes:
 > Ok fine to live with that for security reason, but the socket will be dead
 > for ever! (the only way to remove it is to reboot the machine)

If you kill the application, the queue is emptied and tossed
by the kernel.

Later,
David S. Miller
davem@redhat.com

