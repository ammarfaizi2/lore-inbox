Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTEPQzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 12:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTEPQzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 12:55:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23974
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264496AbTEPQzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 12:55:02 -0400
Subject: Re: request_firmware() hotplug interface, third round.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Neukum <oliver@neukum.org>
Cc: ranty@debian.org, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
In-Reply-To: <200305161007.31335.oliver@neukum.org>
References: <20030515200324.GB12949@ranty.ddts.net>
	 <200305161007.31335.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053101342.5589.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 May 2003 17:09:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-16 at 09:07, Oliver Neukum wrote:
> So, if I understand you correctly, RAM is only saved if a device
> is hotpluggable and needs firmware only upon intial connection.
> Which, if you do suspend to disk correctly, is no device.

Thats just because the interface is a little warped not the theory.
On a resume you need to reload firmware and you already handle 
rediscovery on USB bus for example because the devices can change


