Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWGaK6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWGaK6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWGaK6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:58:50 -0400
Received: from blinkenlights.ch ([62.202.0.18]:23149 "EHLO blinkenlights.ch")
	by vger.kernel.org with ESMTP id S1751527AbWGaK6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:58:49 -0400
Date: Mon, 31 Jul 2006 12:58:46 +0200
From: Adrian Ulrich <reiser4@blinkenlights.ch>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: ipso@snappymail.ca, matthias.andree@gmx.de, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
Message-Id: <20060731125846.aafa9c7c.reiser4@blinkenlights.ch>
In-Reply-To: <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
References: <1153760245.5735.47.camel@ipso.snappymail.ca>
	<200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
Organization: Bluewin AG
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And EXT3 imposes practical limits that ReiserFS doesn't as well. The big
> > one being a fixed number of inodes that can't be adjusted on the fly,
> 
> Right. Plan ahead.

Ok: Assume that i've read the mke2fs manpage and added more inodes to
my filesystem.

So: What happens if i need to grow my filesystem by 200% after 1-2
years? Can i add more inodes to Ext3 on-the-fly ?

A filesystem with a fixed number of inodes (= not readjustable while
mounted) is ehr.. somewhat unuseable for a lot of people with
big and *flexible* storage needs (Talking about NetApp/EMC owners)

Why are a lot of Solaris-people using (buying) VxFS? Maybe because UFS
also has such silly limitations? (..and performs awkward with trillions
of files..?..)


Ext3 may be a fine and stable Filesystem and works well for a lot of
people. But there are also a lot of people who need 'something' better
like: VxFS, WAFL and Reiser4.

Btw: Do you know Adics 'StorNext Filesystem' ? 
IMHO Ext3 will never be able to do such things...
But with Reiser4.. .. if someone wrote a plugin .. ;-)



Regards,
 Adrian

