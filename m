Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVBAEmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVBAEmo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 23:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVBAEmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 23:42:44 -0500
Received: from waste.org ([216.27.176.166]:28049 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261543AbVBAEmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 23:42:43 -0500
Date: Mon, 31 Jan 2005 20:42:37 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, quilt-dev@nongnu.org
Subject: [ANNOUNCE] quilt.el minor mode for emacs
Message-ID: <20050201044237.GV2891@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've created a minor mode for using quilt in Emacs. I've made it
available at:

http://selenic.com/quilt/

It automatically detects files that are in a quilt hierarchy and
enables itself.

To prevent a common class of screw-up with quilt, it attempts to
determine which files are part of currently applied patches and
toggles the buffer read-only flag appropriately. It also prompts to
save quilted files for various operations so that all changes are
properly picked up.

Comments, suggestions, and additions welcome. This is essentially my
first attempt at doing anything non-trivial in elisp, so go easy on
the flames.

-- 
Mathematics is the supreme nostalgia of our time.
