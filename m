Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423027AbWAMWYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423027AbWAMWYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423025AbWAMWYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:24:19 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:7185 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1423023AbWAMWYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:24:18 -0500
Date: Fri, 13 Jan 2006 17:24:09 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: wireless: recap of current issues (other issues)
Message-ID: <20060113222408.GM16166@tuxdriver.com>
Mail-Followup-To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213237.GH16166@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113213237.GH16166@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other Issues
============

Radiotap headers make sense for an rfmon virtual device.  I don't
think it makes sense for "normal" usage.  Should there be an option
for radiotap headers on non-rfmon links?

Rfmon interferes w/ other interfaces, but may be handy to enter/leave
w/ little effort.  Perhaps a config option for physical device to
suspend/resume all (non-rfmon) virtual devices before/after enabling
rfmon virtual device?  (Would multiple rfmon devices even make sense?
If not, is it worth restricting that?)

What about old hardware w/ inactive maintenance?  Deprecate/remove?
Grandfather them w/ treatment as ethernet devices?  Probably don't
need a pronouncement on this at this time...
-- 
John W. Linville
linville@tuxdriver.com
