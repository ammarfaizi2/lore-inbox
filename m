Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135211AbRDRP1W>; Wed, 18 Apr 2001 11:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135209AbRDRP1D>; Wed, 18 Apr 2001 11:27:03 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:29389 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S135208AbRDRP0w>; Wed, 18 Apr 2001 11:26:52 -0400
Date: Wed, 18 Apr 2001 17:26:42 +0200 (CEST)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE847@orsmsx35.jf.intel.com>
Message-Id: <Pine.LNX.4.31.0104181715370.21805-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Grover, Andrew wrote:

> We are going to need some software that handles button events, as well as
> thermal events, battery events, polling the battery, AC adapter status
> changes, sleeping the system, and more.

Yes, that will be a separate daemon that will also get the events. But I
think it's a good idea to have a simple interface that allows the user to
run arbitrary commands when ACPI events occur, even without acpid running
(think of singleuser mode, embedded systems, ...).

> Unix philosophy: "do one thing and do it well".

Another Unix philosophy: "keep it simple, stupid". :-)

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

