Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbTIQTwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbTIQTwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:52:39 -0400
Received: from vena.lwn.net ([206.168.112.25]:38379 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262884AbTIQTwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:52:37 -0400
Message-ID: <20030917195236.27542.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Dynamic allocation of char majors in the new world order
From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 17 Sep 2003 13:52:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I done wrote:

> The new register_chrdev_region() and cdev_* functions are reasonably easy
> to get a grasp of, for the most part.  But I'm curious about one thing:
> what do you do if you want to use the new functions with dynamic major
> number allocation?

Well, I'm a little slow, but it is possible for things to seep into my
brain eventually.  Further review of the source makes it clear that the
dynamic allocation case is what alloc_chrdev_region() is for.  

Look for a new article in the driver porting series shortly...

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
