Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUCDBWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUCDBWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:22:45 -0500
Received: from attila.bofh.it ([213.92.8.2]:48077 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S261389AbUCDBWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:22:44 -0500
Date: Thu, 4 Mar 2004 02:22:33 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Greg KH <greg@kroah.com>
Cc: Ed Tomlinson <edt@aei.ca>, Michael Weiser <michael@weiser.dinsnail.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040304012233.GB22511@wonderland.linux.it>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Ed Tomlinson <edt@aei.ca>,
	Michael Weiser <michael@weiser.dinsnail.net>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040303000957.GA11755@kroah.com> <20040303095615.GA89995@weiser.dinsnail.net> <200403030722.17632.edt@aei.ca> <20040303151433.GC25687@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303151433.GC25687@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 03, Greg KH <greg@kroah.com> wrote:

 >Users need to learn that the kernel is changing models from one which
 >automatically loaded modules when userspace tried to access the device,
 >to one where the proper modules are loaded when the hardware is found.
This does not solve the problem of drivers which do not have matching
hardware, like PPP and loop device. I do not mind unconditionally loading
these modules at boot, but there has to be a way to recognize them: I do
not think it is acceptable to load *all* modules available on the system
(what is the point of having a modular kernel then?).

-- 
ciao, |
Marco | [4890 diVLsnWO4HAuo]
