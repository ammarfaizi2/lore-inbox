Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWGDSwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWGDSwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 14:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWGDSwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 14:52:51 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:30174 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932331AbWGDSwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 14:52:50 -0400
Message-ID: <44AAB8E8.3040405@garzik.org>
Date: Tue, 04 Jul 2006 14:52:24 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Diego Calleja <diegocg@gmail.com>,
       arjan@infradead.org, zdzichu@irc.pl, helgehaf@aitel.hist.no,
       sithglan@stud.uni-erlangen.de, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>  <20060701170729.GB8763@irc.pl>  <20060701174716.GC24570@cip.informatik.uni-erlangen.de>  <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>  <20060703205523.GA17122@irc.pl>  <1151960503.3108.55.camel@laptopd505.fenrus.org>  <44A9904F.7060207@wolfmountaingroup.com>  <20060703232547.2d54ab9b.diegocg@gmail.com> <1151965033.16528.28.camel@localhost.localdomain> <Pine.LNX.4.61.0607041643470.4190@yvahk01.tjqt.qr> <44AA98B5.5060400@wolfmountaingroup.com>
In-Reply-To: <44AA98B5.5060400@wolfmountaingroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey V. Merkey wrote:
> The old novell model is simple. When someone unlinks a file, don't 
> delete it, just mv it to another special directory called DELETED.SAV. 
> Then setup the
> fs space allocation to reuse these files when the drive fills up by 
> oldest files first. It's very simple. Then you have a salvagable file 
> system.

Such a scheme makes it much more difficult to allocate large, contiguous 
runs of free space for storing newly written data.

	Jeff


