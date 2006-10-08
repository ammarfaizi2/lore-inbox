Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWJHPnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWJHPnp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWJHPnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:43:45 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:51681 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751230AbWJHPno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:43:44 -0400
Date: Sun, 8 Oct 2006 17:42:57 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor coding style fix
In-Reply-To: <9a8748490610080829r54053e14ud8c7b02c8f39476c@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0610081742020.26553@yvahk01.tjqt.qr>
References: <452913DB.4010409@gmail.com> <9a8748490610080829r54053e14ud8c7b02c8f39476c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Kernel generally follow the style
>> 
>> if (func()) {
>> /* failed case */
>> } else {
>> /* success */
>> }

Here's my: NAK.
(At best it should be if(foo != 0) rather than if(foo), but that's just me.)

> I really liked the old code better. If in the future
> init_srcu_struct() is changed to also return >0 for some conditions,
> then that would not previously have triggered BUG(), but after your
> changes it will. The code, as it were, perfectly expressed what it
> wanted to happen - if it returns less than zero it's a BUG().
> I say leave it alone.

I agree here.


	-`J'
-- 
