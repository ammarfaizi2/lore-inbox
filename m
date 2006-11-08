Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754651AbWKHSgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbWKHSgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754654AbWKHSgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:36:47 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:52805 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1754651AbWKHSgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:36:47 -0500
In-Reply-To: <20061108180154.GC15063@khazad-dum.debian.net>
Subject: Re: How to document dimension units for virtual files?
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, pavel@ucw.cz
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OFAE836F2F.99AEEBE4-ON41257220.0065E716-41257220.006655A4@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 8 Nov 2006 19:37:45 +0100
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 08/11/2006 19:39:50
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrique,

Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote on 11/08/2006 07:01:54
PM:
> On Wed, 08 Nov 2006, Michael Holzheu wrote:
> Please consider using ":" to separate units and other specific qualifiers
> (e.g. led colors) from the main attribute name.  This helps userspace
> applications to behave better when faced with stuff like "a_b_c:unit1"
and
> "a_b_c:unit2" at the same time.

":" is probably not a good idea.  I think it is treated by the bash as a
special
character. Try:

# touch test:ms
# ls test <press tab>
# ls test\:ms

Michael

