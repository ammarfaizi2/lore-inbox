Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbWHXSgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbWHXSgZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWHXSgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:36:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6104 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030445AbWHXSgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:36:24 -0400
Subject: RE: Generic Disk Driver in Linux
From: Arjan van de Ven <arjan@infradead.org>
Reply-To: arjan@infradead.org
To: Aleksey Gorelov <dared1st@yahoo.com>
Cc: jengelh@linux01.gwdg.de, daniel.rodrick@gmail.com,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-newbie@vget.kernel.org, satinder.jeet@gmail.com
In-Reply-To: <20060824181935.90856.qmail@web83102.mail.mud.yahoo.com>
References: <20060824181935.90856.qmail@web83102.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 24 Aug 2006 20:36:13 +0200
Message-Id: <1156444573.3014.82.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 11:19 -0700, Aleksey Gorelov wrote:
> >From: linux-kernel-owner@vger.kernel.org 
> >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jan Engelhardt
> >>
> >> I was curious that can we develop a generic disk driver that could
> >> handle all the kinds of hard drives - IDE, SCSI, RAID et al?
> >
> >ide_generic
> >sd_mod
> >
> >All there, what more do you want?
> 
> Unfortunately, not _all_. DMRAID does not support all fake raids yet. 

Hi,

it'll be easier and quicker to rev engineer 5 more formats than it will
be to get the bios thing working ;) And the performance of the bios
thing will be really really bad... (hint: real mode can access only 1Mb
of memory, so you will bounce buffer all IO's)

Greetings,
   Arjan van de Ven

