Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVDEPDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVDEPDx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVDEPC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:02:57 -0400
Received: from mail1.upco.es ([130.206.70.227]:52655 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261773AbVDEPBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:01:08 -0400
Date: Tue, 5 Apr 2005 17:01:05 +0200
From: Romano Giannetti <romanol@upco.es>
To: Pavel Machek <pavel@ucw.cz>
Cc: Stefan Schweizer <sschweizer@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Message-ID: <20050405150105.GA26149@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	Pavel Machek <pavel@ucw.cz>, Stefan Schweizer <sschweizer@gmail.com>,
	Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at> <20050401113335.GA13160@elf.ucw.cz> <e79639220504010938582bade6@mail.gmail.com> <20050402085935.GC1330@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050402085935.GC1330@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Same way to debug it, then.... try minimal drivers.

Yes, the lifer of a kernel debugger is hard... 

Pavel, one question (maybe stupid, I am not at all an expert). Wouldn't be
possible to add a printk when invoking and returning from suspend/resume
methods of drivers, telling if they are specific or generic on? Maybe with
the help of the serial console could be an aid to detect wich drivers are
failing in that case. It could have helped the ALPS case, methinks.
Obviously, under a "kernel hacking" config. I'd love to be able to make it
myself, but I do not know where to start... 

        Romano 



-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
