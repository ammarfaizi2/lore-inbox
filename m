Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVGUImW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVGUImW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 04:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVGUImW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 04:42:22 -0400
Received: from ns.firmix.at ([62.141.48.66]:29856 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S261682AbVGUImV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 04:42:21 -0400
Subject: Re: a 15 GB file on tmpfs
From: Bernd Petrovitsch <bernd@firmix.at>
To: Bastiaan Naber <naber@inl.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200507201416.36155.naber@inl.nl>
References: <200507201416.36155.naber@inl.nl>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 21 Jul 2005 10:42:12 +0200
Message-Id: <1121935332.21421.10.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-20 at 14:16 +0200, Bastiaan Naber wrote:
[...]
> I have a 15 GB file which I want to place in memory via tmpfs. I want to do 
> this because I need to have this data accessible with a very low seek time.

Apart fromn the 32-vs-64bit thing: Isn't it enough (and simpler and more
flexible) to mmap(2) that file and mlock(2) it afterwards?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

