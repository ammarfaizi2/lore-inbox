Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265322AbUAFDL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265320AbUAFDL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:11:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6544 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266066AbUAFDKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:10:22 -0500
Date: Mon, 5 Jan 2004 19:04:39 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple 
 map/unmaps
Message-Id: <20040105190439.0a5f7370.davem@redhat.com>
In-Reply-To: <20040106040640.1d2bcbd8.ak@suse.de>
References: <200401051929.i05JTsM0000014248@mudpuddle.cs.wustl.edu.suse.lists.linux.kern
	el>
	<20040105112800.7a9f240b.davem@redhat.com.suse.lists.linux.kernel>
	<p73brpi1544.fsf@verdi.suse.de>
	<20040105130118.0cb404b8.davem@redhat.com>
	<20040105223158.3364a676.ak@suse.de>
	<1073347548.2439.33.camel@mulgrave>
	<20040106040640.1d2bcbd8.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004 04:06:40 +0100
Andi Kleen <ak@suse.de> wrote:

> It's ok. I fixed the code now[1] If you have other undocumented requirements
> you should document them though, otherwise there may be more problems.
> Since merging is disabled by default now it won't trigger anyways.

I totally agree with you Andi, not documenting this properly was an
oversight and not intentional.
