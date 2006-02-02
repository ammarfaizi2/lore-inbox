Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWBBNC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWBBNC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 08:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWBBNC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 08:02:27 -0500
Received: from smtp17.wanadoo.fr ([193.252.23.111]:57235 "EHLO
	smtp17.wanadoo.fr") by vger.kernel.org with ESMTP id S1751040AbWBBNC0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 08:02:26 -0500
X-ME-UUID: 20060202130223719.AFC2370000BE@mwinf1707.wanadoo.fr
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: oliver@neukum.org, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jerome.lacoste@gmail.com,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
In-Reply-To: <43E20047.nail4TP1PULVQ@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <43DF3C3A.nail2RF112LAB@burner>
	 <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com>
	 <200601311333.36000.oliver@neukum.org> <1138867142.31458.3.camel@capoeira>
	 <43E1EAD5.nail4R031RZ5A@burner> <1138880048.31458.31.camel@capoeira>
	 <43E20047.nail4TP1PULVQ@burner>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1138885334.31458.42.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 02 Feb 2006 14:02:14 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörg,

On Thu, 2006-02-02 at 13:51, Joerg Schilling wrote:
> Xavier Bestel <xavier.bestel@free.fr> wrote:
> > Well ... from your sayings it seems Linux is supported by HAL but not by
> > libscg. 
> 
> Libscg is _the_ HAL for cdrecord. It is availaible the same way as today since
> 10 years.

I understand your point, but believe me, *nobody* wants one HAL per
application. There need to be only one HAL for all, and as freedesktop's
HAL has the functionnality necessary for cdrecord (minus perhaps a few
fixable bugs), but libscg is SCSI-only (and for the matter, can't work
with Linux IDE devices), cdrecord would better move to HAL for its CD
writer discovery.

Of course, the perfect outcome of this would be you turning cdrecord
into a shared library which could be used by apps as they see fit, using
their own means of selecting a CD writer and reporting errors and
completion.

Regards,
	Xav


