Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTJIOWp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbTJIOWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:22:45 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:47291 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262225AbTJIOWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:22:43 -0400
X-Sender-Authentication: net64
Date: Thu, 9 Oct 2003 16:22:41 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux.nics@intel.com
Cc: marcelo.tosatti@cyclades.com, jgarzik@pobox.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem with e1000 driver from kernel 2.4.23-pre6
Message-Id: <20031009162241.00e93abb.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just found out that the e1000-driver included in the latest kernel
2.4.23-pre6 has a problem cooperating with keepalived. Keepalived uses netlink
to find out about interfaces being up or down. This works well with eepro100
driver from Don Becker (or tulip), but does not work at all with e1000.
Probably for the same reason mii-tool does not show anything useful either.
Is this fixable inside the e1000-driver? Should keepalived be fixed in any way?

Regards,
Stephan
