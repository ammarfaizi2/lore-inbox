Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291751AbSBANYn>; Fri, 1 Feb 2002 08:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291754AbSBANYd>; Fri, 1 Feb 2002 08:24:33 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:43794 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S291751AbSBANYZ>; Fri, 1 Feb 2002 08:24:25 -0500
Date: Fri, 1 Feb 2002 21:20:11 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Greg Louis <glouis@dynamicro.on.ca>, <VANDROVE@vc.cvut.cz>,
        <jdthood@mail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>, <skraw@ithnet.com>,
        Jeff Chua <jchua@fedex.com>
Subject: Re: 2.4.18-pre7 slow ... apm problem
In-Reply-To: <20020130165058.0dc3147f.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0202012116480.554-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/01/2002
 09:24:15 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/01/2002
 09:24:18 PM,
	Serialize complete at 02/01/2002 09:24:18 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Stephen Rothwell wrote:

> This is rather longer than needed, it has some tidy ups from Thomas
> Hood as well.  I have basically simplified the idle loop and added
> a couple of more points where it can escape.

applied, and tested, same problem still persist. Only way right now is to
set idle_threshold to 100.

Sorry for the late reply.


Jeff.

