Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTGHRFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbTGHRFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:05:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17798 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264830AbTGHRFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:05:53 -0400
Date: Tue, 8 Jul 2003 18:20:28 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, hannal@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Fastwalk: reduce cacheline bouncing of d_count (Changelog@1.1024.1.11)
Message-ID: <20030708172028.GB1939@parcelfarce.linux.theplanet.co.uk>
References: <16138.53118.777914.828030@charged.uio.no> <1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk> <16138.56467.342593.715679@charged.uio.no> <1057677613.4358.33.camel@dhcp22.swansea.linux.org.uk> <20030708164426.GB10004@www.13thfloor.at> <1057683213.5228.3.camel@dhcp22.swansea.linux.org.uk> <20030708170628.GA13593@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030708170628.GA13593@www.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 07:06:28PM +0200, Herbert Poetzl wrote:
> every change (if it's not a bugfix, and even those) bear
> a risk, what I like about the fastwalk patch is not the

exactly.  2.4 is not the place for cleanups that make the code easier
to read because those cleanups can introduce new bugs.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
