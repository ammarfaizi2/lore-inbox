Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVJYIBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVJYIBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 04:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVJYIBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 04:01:39 -0400
Received: from dslsmtp.struer.net ([62.242.36.21]:3599 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S932086AbVJYIBj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 04:01:39 -0400
Message-ID: <23145.194.237.142.24.1130227295.squirrel@194.237.142.24>
In-Reply-To: <435DE018.5000902@droids-corp.org>
References: <435DE018.5000902@droids-corp.org>
Date: Tue, 25 Oct 2005 10:01:35 +0200 (CEST)
Subject: Re: Makefile : can I use both 'O=' and 'M=' ?
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Olivier MATZ" <zer0@droids-corp.org>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi all,
>
> When compiling an external module, is it possible to use both 'O=...'
> and 'M=...' in the make command line ?

Hi Oliver.

O=... is used to tell kbuild where the output of the kernel compile is
placed.
There is no support for specifying a separate object directory when
compiling external modules.

   Sam


