Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWJQAw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWJQAw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 20:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWJQAw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 20:52:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:405 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030182AbWJQAwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 20:52:25 -0400
Date: Mon, 16 Oct 2006 20:52:15 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: mjg59@srcf.ucam.org
Subject: another broken via pci quirk.
Message-ID: <20061017005215.GD32681@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, mjg59@srcf.ucam.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I got two separate reports that the quirk_via_abnormal_poweroff
PCI quirk added in 2.6.17 breaks booting on some boxes.
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=210817

This has been around for a while, as it seems to also be affecting
Ubuntu users: https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.17/+bug/63134

We seem to have a habit of running VIA quirks on systems that don't always
need them. :-/

	Dave

-- 
http://www.codemonkey.org.uk
