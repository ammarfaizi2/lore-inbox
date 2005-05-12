Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVELI6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVELI6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVELIzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:55:19 -0400
Received: from exosec.net1.nerim.net ([62.212.114.195]:42405 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S261350AbVELIsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:48:43 -0400
Date: Thu, 12 May 2005 10:48:41 +0200
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Cc: chrisw@osdl.org, marcelo.tosatti@cyclades.com
Subject: Linux 2.4.30-hf2 - security fix
Message-ID: <20050512084841.GA14972@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

here comes the second hotfix for 2.4.30, which addresses the vulnerability
reported in CAN-2005-1263 by Paul Starzetz from ISEC :

   http://linux.exosec.net/kernel/2.4-hf/

The fix was backported and tested by Chris Wright from Greg's 2.6 patch.

Every 2.4.30[-hf1] user should apply the fix. 2.4.29 users can download
the 2.4.29-hf9 release from the same site.

Changelog From 2.4.30-hf1 to 2.4.30-hf2 (semi-automated)
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.30-vuln-CAN-2005-1263-1                           (Greg KH, Chris Wright)

  From Paul Starzetz: A locally exploitable flaw has been found in the Linux
  ELF binary format loader's core dump function that allows local users to
  gain root privileges and also execute arbitrary code at kernel privilege
  level.

Regards,
Willy

