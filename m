Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTFKKGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 06:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTFKKGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 06:06:08 -0400
Received: from quechua.inka.de ([193.197.184.2]:59280 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264308AbTFKKGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 06:06:06 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dm: Repair persistent minors
In-Reply-To: <20030611100542.GD2499@fib011235813.fsnet.co.uk>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19Q2ho-0001NC-00@calista.inka.de>
Date: Wed, 11 Jun 2003 12:19:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030611100542.GD2499@fib011235813.fsnet.co.uk> you wrote:
> Split the dm_create() function into two variants, depending on whether
> you want the device to have a specific minor number.  This avoids
> the broken overloading of the minor argument to the old dm_create().

why dont you just call dm_create_with_minor() from dm_create and skip the
create_aux function? the create_aux function is pretty badly named, me
thinks. you sould at least call it dm_create_aux.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
