Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWJVRGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWJVRGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWJVRGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:06:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:18138 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751309AbWJVRGj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:06:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
Date: Sun, 22 Oct 2006 19:06:32 +0200
User-Agent: KMail/1.9.5
Cc: Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <4537818D.4060204@qumranet.com> <200610221851.06530.arnd@arndb.de> <453BA3E9.4050907@qumranet.com>
In-Reply-To: <453BA3E9.4050907@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610221906.33085.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 19:01, Avi Kivity wrote:
> > While we don't have it yet, we're thinking about adding a sputop
> > or something similar that shows the utilization of spus. You don't
> > need that one, since get exactly that with the regular top, but you
> > might want to have a tool that prints statistics about how often
> > your guests drop out of the virtualisation mode, or the number
> > of interrupts delivered to them.
> >
> >  
>
> We have a debugfs interface and a kvm_stat script which shows exactly
> that (including a breakdown of the reasons for the exit).

Ok, good. But with your own file system, you wouldn't need debugfs
any more and have all information about a guest in one place.

	Arnd <><
