Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVBBQ4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVBBQ4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVBBQ4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:56:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20401 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262388AbVBBQ4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:56:38 -0500
Date: Wed, 2 Feb 2005 08:56:28 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, zaitcev@redhat.com
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050202085628.49f809a0@localhost.localdomain>
In-Reply-To: <20050202102033.GA2420@ucw.cz>
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
	<20050201234148.4d5eac55@localhost.localdomain>
	<20050202102033.GA2420@ucw.cz>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:20:33 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:

> Well, you removed the scaling to the touchpad resolution, which will
> cause ALPS touchpad to be significantly slower than Synaptics touchpads.
> Similarly, the screen size used to be taken into account, but probably
> that was a mistake, since the value is usually left at default and
> doesn't correspond to the real screen size.

Exactly. And it works much better now.

-- Pete
