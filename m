Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293314AbSCGF7K>; Thu, 7 Mar 2002 00:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293379AbSCGF7B>; Thu, 7 Mar 2002 00:59:01 -0500
Received: from host-65-195-161-157.aus.half.com ([65.195.161.157]:6395 "EHLO
	aus-exm-01.corp.ebay.com") by vger.kernel.org with ESMTP
	id <S293314AbSCGF6y>; Thu, 7 Mar 2002 00:58:54 -0500
Message-ID: <6B6D37BA3067914B85085671A1D3293A1E55CC@aus-exm-01.corp.ebay.com>
From: "Busch, Jeff" <jbusch@ebay.com>
To: "'Chris Friesen'" <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [opensource] Re: Petition Against Official Endorsement of Bit
	Keeper  by Linux Maintainers
Date: Thu, 7 Mar 2002 00:00:14 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just wanted to throw in my two cents.  I dislike clearcase.  
> It's dog slow,
> doesn't support atomic updates of multiple files, and is 
> generally a pain in the
> butt to use.

Yep.  The kernel restrictions on ClearCase are hideous.  Right now, AFAIK,
the newest supported kernel on RedHat 7.1 is RedHat's 2.4.9-6.  They ship
binary-only precompiled modules and blow up if you try to use an unknown
version.  If it doesn't blow up, you can only use it in a "restricted" mode
which disables dynamic views.

> Unfortunately, its the official versioning system at work and 
> all new projects
> are strongly encouraged to use it.

Good luck.  It's a royal pain to set up a development environment that does
not look like your production environment, especially when your dev servers
crash and lose all of their views and any un-checked-in files.

Jeff
