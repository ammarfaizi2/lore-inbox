Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263100AbREaOBv>; Thu, 31 May 2001 10:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbREaOBl>; Thu, 31 May 2001 10:01:41 -0400
Received: from nick.dcs.qmw.ac.uk ([138.37.88.61]:63249 "EHLO dcs.qmw.ac.uk")
	by vger.kernel.org with ESMTP id <S263100AbREaOBc>;
	Thu, 31 May 2001 10:01:32 -0400
Date: Thu, 31 May 2001 15:01:31 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: losetup fails (-EINVAL) over tmpfs
Message-ID: <Pine.LNX.4.33.0105311459250.20201-100000@nick.dcs.qmw.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is very probably already known, but it broke the RH71 mkinitrd for me
until I changed its temporary files to be created on /var/tmp :)

