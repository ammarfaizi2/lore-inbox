Return-Path: <linux-kernel-owner+w=401wt.eu-S1751753AbXAOAPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbXAOAPm (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 19:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbXAOAPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 19:15:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33034 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbXAOAPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 19:15:40 -0500
Subject: Re: [patch 00/12] Fix ppc64's writing to struct file_operations
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Alan <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20070115105501.0ec8ead0.sfr@canb.auug.org.au>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
	 <1168735914.3123.317.camel@laptopd505.fenrus.org>
	 <20070114145411.1fd8c985@localhost.localdomain>
	 <20070115105501.0ec8ead0.sfr@canb.auug.org.au>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 14 Jan 2007 16:15:31 -0800
Message-Id: <1168820131.3123.1344.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 10:55 +1100, Stephen Rothwell wrote:
> On Sun, 14 Jan 2007 14:54:11 +0000 Alan <alan@lxorguk.ukuu.org.uk> wrote:
> >
> > This doesn't appea to do the same thing at all. You need to select
> > between two sets of const inode ops instead, otherwise you turn write on
> > arbitarily.
> 
> Or something like below ... (compile tested on pseries, iseries and combined).

ok I was about to do this instead... but you beat me to it.. thanks!

Acked-by: Arjan van de Ven <arjan@linux.intel.com>



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

