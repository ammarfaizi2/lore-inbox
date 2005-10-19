Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVJSBlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVJSBlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVJSBlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:41:15 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:15108 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932454AbVJSBlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:41:14 -0400
Date: Tue, 18 Oct 2005 21:41:03 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com,
       mlindner@syskonnect.de, rroesler@syskonnect.de
Subject: Re: [patch 2.6.14-rc4 0/3] sk98lin: neuter and prepare for removal
Message-ID: <20051019014101.GC6687@tuxdriver.com>
Mail-Followup-To: Stephen Hemminger <shemminger@osdl.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jgarzik@pobox.com, mlindner@syskonnect.de, rroesler@syskonnect.de
References: <10182005213059.12304@bilbo.tuxdriver.com> <4355A390.9090309@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4355A390.9090309@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 06:38:24PM -0700, Stephen Hemminger wrote:
> John W. Linville wrote:
> 
> >These patches take steps towards removing sk98lin from the upstream
> >kernel.
> >
> >	-- Remove sk98lin's MODULE_DEVICE_TABLE to avoid
> >	confusing userland tools about which driver to load;

> I applaud the initiative, but this it is too premature to obsolete the 
> existing driver. There may be lots of chip versions and other variables 
> that make
> the existing driver a better choice.  Maybe eepro100 is a better target
> for removal right now.

That's cool...but I still think the first one (removing the
MODULE_DEVICE_TABLE) is worthwhile.  At least that gets more testers
for skge.

What do you think?

John
-- 
John W. Linville
linville@tuxdriver.com
