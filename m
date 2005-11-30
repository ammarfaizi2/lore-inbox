Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbVK3RfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbVK3RfG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVK3RfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:35:06 -0500
Received: from 81-179-233-34.dsl.pipex.com ([81.179.233.34]:34767 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751481AbVK3RfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:35:04 -0500
Date: Wed, 30 Nov 2005 17:34:40 +0000
To: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
       linuxppc64-dev@ozlabs.org, Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 0/2] 2.6.15rc3mm1 ppc64 compile problems
Message-ID: <exportbomb.1133372080@pinky>
References: <20051129203134.13b93f48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20051129203134.13b93f48.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Testing 2.6.15-rc3-mm1 seems to have issues on ppc64 systems using
the powerpc architecture.  The problems are in the powermac support
relating to the BOOTX_TEXT support.

Following this email are a couple of patches to clean up this build:

powerpc-powermac-adb-fix-dependancy-on-btext_drawchar: fix up a
  dependancy problem on BOOTX_TEXT

powerpc-powermac-adb-fix-udbg_adb_use_btext-warning: clean up a
  warning with unused externals

Comments?

-apw
