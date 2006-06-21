Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbWFUT06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWFUT06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWFUT06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:26:58 -0400
Received: from hera.kernel.org ([140.211.167.34]:22920 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932684AbWFUT05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:26:57 -0400
Date: Wed, 21 Jun 2006 16:27:56 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: linux-kernel@vger.kernel.org
Cc: Willy Tarreau <w@1wt.eu>, Grant Coady <gcoady.lk@gmail.com>
Subject: Linux 2.4.33-rc2
Message-ID: <20060621192756.GB13559@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A few problems appeared on -rc1... More networking security updates.


Summary of changes from v2.4.33-rc1 to v2.4.33-rc2
============================================

Marcelo Tosatti:
      Change VERSION to v2.4.33-rc2

Mikael Pettersson:
      [PATCH 2.4.33-rc1] repair __ide_dma_no_op breakage

Solar Designer:
      [NETFILTER]: Fix do_add_counters race, possible oops or info leak (CVE-2006-0039)

Vlad Yasevich:
      [SCTP]: Validate the parameter length in HB-ACK chunk. (CVE-2006-1857)
      [SCTP]: Respect the real chunk length when walking parameters. (CVE-2006-1858)

Willy Tarreau:
      Fix vfs_unlink/NFS NULL pointer dereference
      range checking for sleep states sent to /proc/acpi/sleep
