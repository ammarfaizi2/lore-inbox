Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWGENf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWGENf5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWGENf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:35:57 -0400
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:54676 "EHLO
	informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S964862AbWGENf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:35:56 -0400
Message-ID: <44ABC034.1010906@tzi.de>
Date: Wed, 05 Jul 2006 15:35:48 +0200
From: Lew Palm <lew@tzi.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>  <20060701170729.GB8763@irc.pl>  <20060701174716.GC24570@cip.informatik.uni-erlangen.de>  <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>  <20060703205523.GA17122@irc.pl>  <1151960503.3108.55.camel@laptopd505.fenrus.org>  <44A9904F.7060207@wolfmountaingroup.com>  <20060703232547.2d54ab9b.diegocg@gmail.com> <1151965033.16528.28.camel@localhost.localdomain> <Pine.LNX.4.61.0607041643470.4190@yvahk01.tjqt.qr> <44AA98B5.5060400@wolfmountaingroup.com>
In-Reply-To: <44AA98B5.5060400@wolfmountaingroup.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey V. Merkey wrote:
> The old novell model is simple. When someone unlinks a file, don't
> delete it, just mv it to another special directory called DELETED.SAV.
> Then setup the
> fs space allocation to reuse these files when the drive fills up by
> oldest files first. It's very simple. Then you have a salvagable file
> system.

A complete foolproof car is a car with a maximum speed of 0 mph.
As a user I give commands to my computer, for example an order to delete a
file. And this is what I expect it to do.
If I want it to move a file to another position in the filesystem, I would
use another command. I don't want my operating system to josh me, that's why
I use Linux.
Stealthy keeping of deleted files somewhere is a security black hole.

But accidents happen. Hardware perishes, users are making mistakes, sometimes
coffee is pouring...
That's why we backup important data regulary.
A not-really-deleting-filesystem wouldn't relieve us of that duty, but would
make a system more insecure and ambiguous.

Lew
