Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263665AbUD2ITF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUD2ITF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 04:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbUD2ITF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 04:19:05 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:11724 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S263665AbUD2ITA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 04:19:00 -0400
Subject: Re: [PATCH] s390 (6/6): oprofile for s390.
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFBBD9980C.B178FFB0-ONC1256E85.002D068F-C1256E85.002DA6C4@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 29 Apr 2004 10:18:38 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 29/04/2004 10:18:39
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> > +#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
>
> this must depend on CONFIG_PROFILING ?

Currently oprofile is the only profiling method implemented for s390.
So this doesn't really change much. But in principle you are right,
as soon as a second profiling method gets added this would have to
be changed to CONFIG_PROFILING.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


