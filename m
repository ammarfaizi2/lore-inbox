Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbVKSBkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbVKSBkL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161121AbVKSBkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:40:10 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:30943 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161111AbVKSBkJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:40:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BS4SkXUF4hDbY1hWYF/8quC/boDm3fPQZwWBA5fyu8tW4Hcw1EEs5CTadqJ3Q1bi8qgTcK5nwCXrntiRQ45bWEyP/oO0Z0sAdOw8azIiPlxHetWBgj4XNp0QzW79CMY663Jc0lM5Psirk+qe4kdEPEElyAqw30EPXZZ8MN6pkX0=
Message-ID: <cbec11ac0511181740w2428b5c5k90bff5322f19aaa3@mail.gmail.com>
Date: Sat, 19 Nov 2005 14:40:08 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: Ed Tomlinson <tomlins@cam.org>
Subject: Re: 2.6.15-rc1-mm1
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200511182024.33858.tomlins@cam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117111807.6d4b0535.akpm@osdl.org>
	 <200511181835.11719.tomlins@cam.org>
	 <20051118235116.GA26405@kroah.com>
	 <200511182024.33858.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Think only the mousedev module is not loaded.  Once I modprobe it the mouse works
> and the /dev/input/mice appears.  The mouse works normally with all buttons and wheels
> acting normal.
>
I was having this on one of my machines. I'll try and track this down
next week probably if it still occurs and use git-bisect on it if
nobody else does first though. I'll check out the thread mentioned as
well.

Ian
--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
