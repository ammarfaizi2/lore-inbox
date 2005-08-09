Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVHIV20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVHIV20 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbVHIV20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:28:26 -0400
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:61195 "EHLO
	smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP
	id S964987AbVHIV2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:28:25 -0400
Date: Tue, 9 Aug 2005 23:25:20 +0200
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] yaird 0.0.11, a mkinitrd based on hotplug concepts
Message-ID: <20050809232520.B12865@banaan.localdomain>
Mail-Followup-To: linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 0.0.11 of yaird is now available at:
	http://www.xs4all.nl/~ekonijn/yaird/yaird-0.0.11.tar.gz

Yaird is a proof of concept perl rewrite of mkinitrd.  It aims to
reliably identify the necessary modules by using the same algorithms
as hotplug, and comes with a template system to to tune the tool for
different distributions and experiment with different image layouts.
It requires a 2.6 kernel with hotplug.  There is a paper discussing it at:

	http://www.xs4all.nl/~ekonijn/yaird/yaird.html

Summary of user visible changes:
     * Support configuration file that determines what the generated
       image should do.  It replaces command line options for root
       file system selection and for NFS support.
     * The file /etc/hotplug/blacklist does not have to exist:
       this can be a machine without hotplug, or with a future
       hotplug version, where blacklisting is delegated to module-init-tools.
       Based on patch by Marian Andre <Marian.Andre@sq.sk>
     * Bugfix: expect characters A-Z, in kernel config entries.
     * Handle kernels that do not have ide-generic.

Changes in version 0.0.10 and 0.0.9 were too small to
merit an announcement:
     * Support legacy keyboard compiled as module.
     * Place the docs under GPL instead of GFDL for the benefit of Debian.

Regards,
Erik

