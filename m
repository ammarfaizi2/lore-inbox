Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWDYUZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWDYUZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWDYUZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:25:36 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:42657 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751472AbWDYUZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:25:36 -0400
Date: Tue, 25 Apr 2006 21:25:26 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Cc: dtor_core@ameritech.net
Subject: Telling the kernel that keys need soft release?
Message-ID: <20060425202526.GA29169@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dell laptops have hotkeys on the top of the keyboard for "hibernate", 
"cd eject", "battery status" and so on. These can be mapped to 
appropriate keycodes, and life is good except for the fact that they 
never produce a key release event. The kernel appears to have code to 
deal with this for the hangul key, but it's hardcoded rather than 
generic.

Is there any way for userspace to tell the event layer that a certain 
keycode should have soft-release? If not, would a patch for this be 
accepted?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
