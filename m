Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbUB1EGI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 23:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbUB1EGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 23:06:08 -0500
Received: from netrider.rowland.org ([192.131.102.5]:19215 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S263146AbUB1EF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 23:05:57 -0500
Date: Fri, 27 Feb 2004 23:05:57 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Does the block layer prevent races between open() and unregister()?
Message-ID: <Pine.LNX.4.44L0.0402272302570.4063-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A classic race that all drivers for hot-unpluggable devices have to deal 
with is the race between open() and unregister() (or disconnect()).

Does the block layer have any mechanism to prevent such races?  Or does it 
rely on the lower-level drivers handling such things by themselves?

Alan Stern

