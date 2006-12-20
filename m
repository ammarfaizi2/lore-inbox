Return-Path: <linux-kernel-owner+w=401wt.eu-S964947AbWLTJ2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWLTJ2I (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 04:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWLTJ2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 04:28:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:42953 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964947AbWLTJ2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 04:28:06 -0500
Subject: Re: sysfs file creation result nightmare
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       Olivier Galibert <galibert@pobox.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061220080133.GA4325@kroah.com>
References: <1165694351.1103.133.camel@localhost.localdomain>
	 <20061209123817.f0117ad6.akpm@osdl.org>
	 <20061209214453.GA69320@dspnet.fr.eu.org>
	 <20061209135829.86038f32.akpm@osdl.org>
	 <20061209223418.GA76069@dspnet.fr.eu.org>
	 <20061209145303.3d5fe141.akpm@osdl.org>
	 <1165712131.1103.166.camel@localhost.localdomain>
	 <20061215154751.86a2dbdd.khali@linux-fr.org>
	 <1166213773.31351.96.camel@localhost.localdomain>
	 <20061215123103.adfbd78b.akpm@osdl.org>  <20061220080133.GA4325@kroah.com>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 20:27:28 +1100
Message-Id: <1166606848.5144.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> sysfs_create_group() and remove_group() handles this just fine right
> now.  Or it should, if not, please let me know and I'll fix it.

Ok, I didn't know about these. I'll have a look. Thanks !

> As for the bin_file stuff, those are very rare.  And I'll gladly take
> patches that keep bad things from happening if you try to remove a file
> that isn't there.

Ben.


