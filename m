Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUIPQFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUIPQFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268247AbUIPQE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:04:26 -0400
Received: from styx.suse.cz ([82.119.242.94]:12678 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S268176AbUIPP5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:57:50 -0400
Date: Thu, 16 Sep 2004 17:58:01 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input: Disable the AUX LoopBack command in i8042.c on Compaq ProLiant
Message-ID: <20040916155801.GA5345@ucw.cz>
References: <200409161509.i8GF90iJ021552@hera.kernel.org> <1095349977.2698.17.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095349977.2698.17.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 05:52:57PM +0200, Arjan van de Ven wrote:

> On Wed, 2004-06-02 at 13:44, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1722.87.1, 2004/06/02 13:44:20+02:00, vojtech@suse.cz
> > 
> > 	input: Disable the AUX LoopBack command in i8042.c on Compaq ProLiant
> > 	       8-way Xeon ProFusion systems, as it causes crashes and reboots
> > 	       on these machines. DMI data is used for determining if the
> > 	       workaround should be enabled.
> > 	
> > 	Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> > 
> 
> is there any reason you do this in dmi_scan.c and not via the "new"
> since some time method where the user gives the dmi code a table with
> callbacks instead ????

There is no such reason other than on 06/02 there wasn't the "new"
method yet, as far as I know. In the same set of patches:

ChangeSet@1.1757.59.2, 2004-06-29 11:59:04+02:00, vojtech@suse.cz
  input: Move Compaq ProLiant DMI handling (ServerWorks/OSB workaround)
         to i8042.c.
         
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
