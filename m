Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTJRT1c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTJRT1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:27:32 -0400
Received: from zork.zork.net ([64.81.246.102]:35205 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261774AbTJRT1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:27:31 -0400
To: "Thomas Giese" <Thomas.Giese@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: X crashes under linux-2.6.0-test7-mm1
References: <003b01c395a8$22dbf270$fb457dc0@tgasterix>
	<6uy8viz7bs.fsf@zork.zork.net>
	<006a01c395ab$4d3f34c0$fb457dc0@tgasterix>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: "Thomas Giese" <Thomas.Giese@gmx.de>,
 <linux-kernel@vger.kernel.org>
Date: Sat, 18 Oct 2003 20:27:27 +0100
In-Reply-To: <006a01c395ab$4d3f34c0$fb457dc0@tgasterix> (Thomas Giese's
 message of "Sat, 18 Oct 2003 21:09:06 +0200")
Message-ID: <6uu166z6qo.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Giese" <Thomas.Giese@gmx.de> writes:

> both are set to
> CONFIG_AGP=m
> CONFIG_AGP_INTEL=m

Were they loaded when you started X?  The message:

(EE) Unable to open /dev/agpgart (No such device)

suggests that they were not.

