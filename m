Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133102AbRDRMUy>; Wed, 18 Apr 2001 08:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133101AbRDRMUp>; Wed, 18 Apr 2001 08:20:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36101 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133097AbRDRMUe>; Wed, 18 Apr 2001 08:20:34 -0400
Subject: Re: change_mtu boundary checking error
To: shmulik.hen@intel.com (Hen, Shmulik)
Date: Wed, 18 Apr 2001 13:22:27 +0100 (BST)
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk ('Alan Cox')
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B271DD@hasmsx52.iil.intel.com> from "Hen, Shmulik" at Apr 18, 2001 12:25:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pqyb-0004bf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But Ethernet is not only for IP, what about other protocols ?

For 2.4 the checks were moved into the protocol layers. Any remaining check
in the driver layer for 68 would be a bug. For 2.2 its not going to change
