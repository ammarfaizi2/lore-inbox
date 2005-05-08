Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVEHUvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVEHUvE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbVEHUvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:51:04 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:9991 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S261679AbVEHUu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 16:50:59 -0400
Date: Sun, 8 May 2005 22:50:47 +0200
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] yaird 0.0.7, a mkinitrd based on hotplug concepts
Message-ID: <20050508225047.B5283@banaan.localdomain>
Mail-Followup-To: linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 0.0.7 of yaird is now available at:
	http://www.xs4all.nl/~ekonijn/yaird/yaird-0.0.7.tar.gz

Yaird is a proof of concept perl rewrite of mkinitrd.  It aims to
reliably identify the necessary modules by using the same algorithms
as hotplug, and comes with a template system to to tune the tool for
different distributions and experiment with different image layouts.
It requires a 2.6 kernel with hotplug.  There is a paper discussing it at:

	http://www.xs4all.nl/~ekonijn/yaird/yaird.html

Summary of user visible changes:
     * Support cryptsetup-luks (Based on a patch by Dick Middleton)
     * Bugfixes
       - cryptsetup, handle multiple hard links to same block special dev
       - cryptsetup, recognise keyword 'none' in /etc/crypttab
       - cryptsetup, keyfile check now for both luks and plain
       - cryptsetup, missing module for aes-cbc-essiv:sha256
       - Fedora template: dash was used instead of ash

On top of the todo list are now:
     * support NFS devices
     * support loopback devices

Regards,
Erik
