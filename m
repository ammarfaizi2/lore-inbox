Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290675AbSA3W3u>; Wed, 30 Jan 2002 17:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290680AbSA3W3l>; Wed, 30 Jan 2002 17:29:41 -0500
Received: from mx.fluke.com ([129.196.128.53]:36368 "EHLO
	evtvir03.tc.fluke.com") by vger.kernel.org with ESMTP
	id <S290675AbSA3W30>; Wed, 30 Jan 2002 17:29:26 -0500
Date: Wed, 30 Jan 2002 14:29:25 -0800 (PST)
From: David Dyck <dcd@tc.fluke.com>
To: <linux-kernel@vger.kernel.org>
Subject: linux/zutil.h needs to move to include/linux
Message-ID: <Pine.LNX.4.33.0201301312050.22570-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed that there is a linux subdirecory under the top level
linux directory, and the contents
 linux/zconf.h
 linux/zutil.h
probably need to be moved to the include/linux directory

as make modules didn't work compile till I did
  mv linux/*  include/linux
  rmdir linux



