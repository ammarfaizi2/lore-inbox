Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270848AbTG0PVE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 11:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270851AbTG0PVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 11:21:04 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:41913 "HELO
	develer.com") by vger.kernel.org with SMTP id S270848AbTG0PU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 11:20:57 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Tomas Szepe <szepe@pinerecords.com>
Subject: Re: [PATCH] Make I/O schedulers optional
Date: Sun, 27 Jul 2003 17:36:05 +0200
User-Agent: KMail/1.5.9
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <200307270319.04168.bernie@develer.com> <20030727095158.GE17724@louise.pinerecords.com>
In-Reply-To: <20030727095158.GE17724@louise.pinerecords.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307271736.05470.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 July 2003 11:51, Tomas Szepe wrote:
> > [bernie@develer.com]
> >
> > +config IOSCHED_AS
> > +	bool "Anticipatory I/O scheduler" if EMBEDDED
> > +	default y
> > +
> > +config IOSCHED_DEADLINE
> > +	bool "Deadline I/O scheduler" if EMBEDDED
> > +	default y
>
> Please provide the help entries too.

I wanted to, and I looked for something in the documentation to
cut & paste instead of making up an inaccurate description myself.

Unfortunately, the documentation wrote by Jens got lost in -mm.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


