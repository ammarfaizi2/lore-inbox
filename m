Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266631AbUHaU4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUHaU4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269150AbUHaUes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:34:48 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:44751 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S269008AbUHaUcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:32:03 -0400
Date: Tue, 31 Aug 2004 22:31:54 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1125457632.20040831223154@tnonline.net>
To: Hubert Chan <hubert@uhoreg.ca>
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea of what reiser4 wants to do with metafiles and why
In-Reply-To: <874qmjm51g.fsf@uhoreg.ca>
References: <41323AD8.7040103@namesys.com> <200408312055.56335.v13@priest.com>
 <36793180.20040831201736@tnonline.net> <200408312235.35733.v13@priest.com>
 <874qmjm51g.fsf@uhoreg.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


V13>> The only thing that changes (from the userland POV) is the way
V13>> someone can enter the 'metadata directory'. This way you don't have
V13>> to have a special name, just a special function and no existing
V13>> application (like tar) can possibly break because it will not know
V13>> how to enter this 'metadata directory'.

> tar won't be able to backup the metadata.  That's the major breakage of
> tar that we're worried about.

  However,  if  we do a "cp fileA fileB" then the metadata and streams
  ought  to be copied too, even if "cp" does not support them. This is
  the  real  challenge. Backup tools like tar can be patched just like
  it has so many times before.


