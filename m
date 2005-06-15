Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVFOK4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVFOK4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 06:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVFOK4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 06:56:34 -0400
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:6419 "EHLO
	smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP
	id S261392AbVFOK4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 06:56:31 -0400
Date: Wed, 15 Jun 2005 12:56:17 +0200
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] yaird 0.0.8, a mkinitrd based on hotplug concepts
Message-ID: <20050615125617.A3099@banaan.localdomain>
Mail-Followup-To: linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 0.0.8 of yaird is now available at:
	http://www.xs4all.nl/~ekonijn/yaird/yaird-0.0.8.tar.gz

Yaird is a proof of concept perl rewrite of mkinitrd.  It aims to
reliably identify the necessary modules by using the same algorithms
as hotplug, and comes with a template system to to tune the tool for
different distributions and experiment with different image layouts.
It requires a 2.6 kernel with hotplug.  There is a paper discussing it at:

	http://www.xs4all.nl/~ekonijn/yaird/yaird.html

Summary of user visible changes:
     * Implement NFS root support (TCP, UDP, v2), based on klibc code.
     * Added manual page.
     * Make debugging output and shell break-outs optional,
       triggered by kernel option 'ydebug'.
     * Minor template simplifications.
     * Merge klibc-1.0.14 changes.
     * A Debian package is available (Based on work by Steven Ihde)

	deb http://www.xs4all.nl/~ekonijn/debian/ unstable/

Regards,
Erik
