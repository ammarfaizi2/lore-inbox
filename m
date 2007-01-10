Return-Path: <linux-kernel-owner+w=401wt.eu-S964961AbXAJRFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbXAJRFo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 12:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbXAJRFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 12:05:44 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:1327 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964961AbXAJRFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 12:05:44 -0500
Date: Wed, 10 Jan 2007 18:05:49 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
Message-Id: <20070110180549.ec871845.khali@linux-fr.org>
In-Reply-To: <45A519C8.5000407@mbligh.org>
References: <20070109102057.c684cc78.khali@linux-fr.org>
	<20070109170550.AFEF460C343@tzec.mtu.ru>
	<20070109214421.281ff564.khali@linux-fr.org>
	<20070109133121.194f3261.akpm@osdl.org>
	<Pine.LNX.4.64.0701091520280.3594@woody.osdl.org>
	<20070109152534.ebfa5aa8.akpm@osdl.org>
	<45A519C8.5000407@mbligh.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Wed, 10 Jan 2007 08:52:24 -0800, Martin J. Bligh wrote:
> Andrew Morton wrote:
> > I use it pretty commonly to answer the question "did I remember to install
> > that new kernel I just built before I rebooted"?  By comparing `uname -a'
> > with $TOPDIR/.version.
> 
> Yup, we need to do the same thing in automated testing. Especially when
> you're doing lilo -R, and don't know if you ended up fscking or panicing
> during attempted reboot to new kernel.
> 
> Better would be a checksum of the vmlinux vs the running kernel text,
> but that seems to be impossible due to code rewriting. Could we embed
> a checksum in a little /proc file for this?

What would this allow that our current autoincrementing counter doesn't?

-- 
Jean Delvare
