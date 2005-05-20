Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVETQoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVETQoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 12:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVETQoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 12:44:23 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:33424 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261480AbVETQoU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 12:44:20 -0400
Subject: Re: Illegal use of reserved word in system.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@gmail.com>
Cc: "Gilbert, John" <JGG@dolby.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e99705052004493a4cdcd2@mail.gmail.com>
References: <2692A548B75777458914AC89297DD7DA08B08670@bronze.dolby.net>
	 <1116524233.21358.292.camel@localhost.localdomain>
	 <21d7e99705052004493a4cdcd2@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116607348.7065.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 May 2005 17:42:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well not a bug :-) but lets call it a C++ incompatibility .. I'll see
> how much work it is to change this everywhere it is used..  I don't
> really want to break loads of userspace apps.. not that many drm apps
> exist.. and probably very few of them use the virtual pointer...

You don't have to change it - its possible to use ifdefs for C++ to
change the name only for C++ usage.

