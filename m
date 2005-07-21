Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVGUEqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVGUEqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 00:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVGUEqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 00:46:54 -0400
Received: from [216.208.38.107] ([216.208.38.107]:51619 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S261615AbVGUEqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 00:46:53 -0400
Subject: Re: [PATCH] Convert refrigerator() to try_to_freeze()
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050719135425.GA2410@elf.ucw.cz>
References: <1121659148.13493.58.camel@localhost>
	 <20050719135425.GA2410@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121921293.2938.197.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 21 Jul 2005 14:48:14 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On the testing twice, fair enough. I'll send a new version with the
refrigerator changes, as jbd won't need that dirty big if..else then
since there's no danger of a deadlock.

Regards,

Nigel

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

