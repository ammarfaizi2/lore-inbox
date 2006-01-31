Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWAaQRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWAaQRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWAaQRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:17:20 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:41345 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751091AbWAaQRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:17:19 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC/RFT] finally solve "swsusp fails with mysqld" problem
Date: Tue, 31 Jan 2006 17:17:56 +0100
User-Agent: KMail/1.9.1
Cc: seife@suse.de, Nigel Cunningham <nigel@suspend2.net>,
       linux-kernel@vger.kernel.org
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601310102.00646.rjw@sisk.pl> <20060131092726.GA2718@elf.ucw.cz>
In-Reply-To: <20060131092726.GA2718@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601311717.56918.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 31 January 2006 10:27, Pavel Machek wrote:
> 
> Place refrigerator hook at more clever place; avoids "system can't be
> suspended while mysqld running" problem.
> 
> I'd like you to test it. It looks correct to me, and it is actually a
> solution, not a workaround like my previous tries. It still does not
> solve suspend while running stress tests.

Which kernel is it against?  It does not apply to the recent -mm ...

Rafael
