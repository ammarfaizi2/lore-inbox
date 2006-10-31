Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423516AbWJaP6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423516AbWJaP6W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423521AbWJaP6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:58:22 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:57240 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1423516AbWJaP6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:58:21 -0500
Date: Tue, 31 Oct 2006 16:57:56 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
       Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: feature-removal-schedule obsoletes
Message-ID: <20061031155756.GA23021@wohnheim.fh-wedel.de>
References: <45324658.1000203@gmail.com> <20061016133352.GA23391@lst.de> <200610242124.49911.arnd@arndb.de> <4543162B.7030701@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4543162B.7030701@drzeus.cx>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 October 2006 10:34:51 +0200, Pierre Ossman wrote:
> 
> What should be used to replace it? The MMC block driver uses it to
> manage the block device queue. I am not that intimate with the block
> layer so I do not know the proper fix.

Why does the MMC block driver use a thread?  Is there a technical
reason for this or could it be done in original process context as
well, removing some code and useless cpu scheduler overhead?

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein
