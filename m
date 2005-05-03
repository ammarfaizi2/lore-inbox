Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVECWgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVECWgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVECWeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:34:13 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:61969 "EHLO
	smtp-vbr13.xs4all.nl") by vger.kernel.org with ESMTP
	id S261876AbVECWdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:33:10 -0400
Date: Wed, 4 May 2005 00:32:58 +0200
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] yaird 0.0.6, a mkinitrd based on hotplug concepts
Message-ID: <20050504003257.A21607@banaan.localdomain>
Mail-Followup-To: linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 0.0.6 of yaird is now available at:
	http://www.xs4all.nl/~ekonijn/yaird/yaird-0.0.6.tar.gz

Yaird is a proof of concept perl rewrite of mkinitrd.  It aims to
reliably identify the necessary modules by using the same algorithms
as hotplug, and comes with a template system to to tune the tool for
different distributions and experiment with different image layouts.
It requires a 2.6 kernel with hotplug.  There is a paper discussing it at:

	http://www.xs4all.nl/~ekonijn/yaird/yaird.html

Summary of user visible changes for version 0.0.6
     * Support cryptsetup.  See the README file, see HTML documentation.
     * Support aliases and options in modprobe.conf,
       simply by using modprobe rather than doing a reimplementation in perl.
     * tested with ulibc
     * Bugfixes:
       - failure to generate image on systems without LVM
       - overcrowded /dev under Debian with udev
       - failure to generate image if multiple links to same raid device exist
       - uninitialised value in verbose output

On top of the todo list are now:
     * support NFS devices
     * support cryptsetup-luks
     * support loopback devices

Regards,
Erik
