Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUCDLbC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 06:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbUCDLbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 06:31:02 -0500
Received: from upco.es ([130.206.70.227]:17603 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261843AbUCDLbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 06:31:00 -0500
Date: Thu, 4 Mar 2004 12:30:57 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040304113057.GA13365@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	linux-kernel@vger.kernel.org
References: <20040303000957.GA11755@kroah.com> <20040303095615.GA89995@weiser.dinsnail.net> <200403030722.17632.edt@aei.ca> <20040303151433.GC25687@kroah.com> <20040303225305.GB30608@weiser.dinsnail.net> <20040304012531.GC2207@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040304012531.GC2207@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 05:25:31PM -0800, Greg KH wrote:
> 
> The fact that module unload even works today is a blessing due to all of
> the well-documented issues involved.  I doubt any distro will enable
> module unloading because of it.
> 

while wholeheartly agreeing with you in this statement, I had to compile
modules with remove enabled for a show-stopping reason: suspend. After
resume, sound, usb mouse, pcmcia devices would not come back to life if I do
not rmmod before and reload after going to S4. I quite understand that this
is a driver problem (bug?), but for my notebook module remove is a necessary
workaround. 

            	Romano 

(tried PMSIK, SWSUSP, SWSUPS2 in 2.6.1, PMDISK works --- Vaio FX701). 

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
