Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265411AbTLHN40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265412AbTLHN4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:56:25 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:42476 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S265411AbTLHN4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:56:24 -0500
X-Sender-Authentication: net64
Date: Mon, 8 Dec 2003 14:56:22 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-ns83820@kvack.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem Report: ns83820 / 802.1Q vlan / 2.4.23
Message-Id: <20031208145622.52d4ea11.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just experienced a problem with ns83820 and 802.1Q vlan support. It seems
that incoming packets get dropped if the device is connected to a tagged switch
port. Reducing the mtu solves the problem but is of course not nice.
I remember some old docs where it says there can be problems because of the
oversized tagged packets. Intel e100 seems to work flawlessly in same setup.

Regards,
Stephan
