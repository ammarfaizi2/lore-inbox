Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751879AbWJMU1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbWJMU1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWJMU1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:27:53 -0400
Received: from web83103.mail.mud.yahoo.com ([216.252.101.32]:61090 "HELO
	web83103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751879AbWJMU1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:27:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=veJo/OfLKgIm63c1iebN7e8spOcJ7wSabLfMzFe8hNT4cTZnsZNDexfWI1KRh6VLhETr1wEwdnG55UREYbZZDtLXiSaaKe2jB7nur2+/UK3vIFTU+elCYVOg4PXlRuPZOiSfslO79qFpbRWE8KflU5VLfhmSI9d2qMfISm9Ui10=  ;
Message-ID: <20061013202752.4101.qmail@web83103.mail.mud.yahoo.com>
Date: Fri, 13 Oct 2006 13:27:52 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: Machine reboot
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: xhejtman@mail.muni.cz, linux-kernel@vger.kernel.org, magnus.damm@gmail.com,
       pavel@suse.cz
In-Reply-To: <452F1142.3000400@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Auke Kok <auke-jan.h.kok@intel.com> wrote:

>
> >> interesting, do you do that because it specifically fixes a problem you have? if so, I'd 
> >> like to know about it :)
> >>
> >> Auke
> >>
> > I'm just trying to localize the issue. 
> > Since right before machine stalls during reboot I see something like
> > 
> > ACPI: PCI interrupt for device 000:00:19.0 disabled
> > Restarting system.
> 
> that's quite a normal message, not sure why that would constitute a problem.
It's not the problem at all, but served as a hint for me to try unloading driver.
However, from latest Lukas's findings, it seems that something (_not_ in the e1000 driver) in
between 2.6.18 & 2.6.19-rc2 fixes it. 

Aleks.
