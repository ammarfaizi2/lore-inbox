Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752046AbWJWWNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbWJWWNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 18:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWJWWNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 18:13:36 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:59585 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1752046AbWJWWNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 18:13:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Date: Tue, 24 Oct 2006 00:12:31 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
References: <1161576735.3466.7.camel@nigel.suspend2.net> <20061023105022.8b1dc75d.akpm@osdl.org> <20061023213943.GA21361@srcf.ucam.org>
In-Reply-To: <20061023213943.GA21361@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610240012.32300.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 October 2006 23:39, Matthew Garrett wrote:
> On Mon, Oct 23, 2006 at 10:50:22AM -0700, Andrew Morton wrote:
> 
> > Apparently uswsusp has gained support for S3 while the in-kernel driver
> > does not support S3.  That's disappointing.
> 
> I'm still not sure why that's an especially desirable feature.

Well, I know of at least one user of it (not me). ;-)

> Every laptop I've played with will automatically resume from S3 when the 
> battery level becomes critical, which gives you the opportunity to 
> suspend to disk. And when it doesn't, you can generally emulate it using 
> the ACPI alarm to wake up. Is there really a significant quantity of 
> hardware out there that doesn't support either of these?

I think there is.


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
