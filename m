Return-Path: <linux-kernel-owner+w=401wt.eu-S1161151AbXAEQxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbXAEQxA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 11:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbXAEQxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 11:53:00 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:48925 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161152AbXAEQw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 11:52:59 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: [-mm patch] lockdep: possible deadlock in sysfs
Date: Fri, 5 Jan 2007 17:53:04 +0100
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, maneesh@in.ibm.com, oliver@neukum.name
References: <20070104220200.ae4e9a46.akpm@osdl.org> <200701051613.25882.oliver@neukum.org> <20070105164252.GG17863@slug>
In-Reply-To: <20070105164252.GG17863@slug>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701051753.05168.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 5. Januar 2007 17:42 schrieb Frederik Deweerdt:
> On Fri, Jan 05, 2007 at 04:13:25PM +0100, Oliver Neukum wrote:
> > Am Freitag, 5. Januar 2007 13:16 schrieb Frederik Deweerdt:
> > > On Thu, Jan 04, 2007 at 10:02:00PM -0800, Andrew Morton wrote:
> > > > 
> > > > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/
> > > > 
> > are you sure there's a code path that takes these locks in the reverse order?
> > I've looked through the code twice and not found any. It doesn't make much
> > sense to first lock the file and afterwards the directory.
> You're right, an annotation should be enough, what do you think?

I agree.

	Regards
		Oliver
