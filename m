Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275211AbTHAKFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275212AbTHAKFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:05:53 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:54022 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S275211AbTHAKFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:05:51 -0400
To: linux-kernel@vger.kernel.org
Subject: IP multicast errors with linux 2.6.0-test2 and SiS900
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 01 Aug 2003 12:02:44 +0200
Message-ID: <yw1xznitk857.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm experiencing some strange behavior with IP multicast in linux
2.6.0-test2 on a SiS900 NIC.

It will only receive multicast packets with destination address
239.1.1.*, unless I "ifconfig eth0 allmulti".  With allmulti set, all
multcast addresses are received.  Setting promisc mode also does the
trick.

This isn't the intended bahavior, is it?

-- 
Måns Rullgård
mru@users.sf.net
