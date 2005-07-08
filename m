Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVGHEQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVGHEQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 00:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVGHEQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 00:16:54 -0400
Received: from ozlabs.org ([203.10.76.45]:52202 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262581AbVGHEQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 00:16:53 -0400
Subject: device_find broken in 2.6.11?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 08 Jul 2005 14:16:53 +1000
Message-Id: <1120796213.12218.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

	I was getting oopses in kset_find_obj when calling device_find in
2.6.11.12.  Noone else in the kernel uses device_find, but I couldnt'
see anything wrong with it (mind you, I can't understand the
kset_find_obj code to judge it).

	Iterating manually using bus_for_each_dev works though.

Known problem?
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

