Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbUK1LWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUK1LWN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 06:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbUK1LWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 06:22:13 -0500
Received: from rev.193.226.233.139.euroweb.hu ([193.226.233.139]:10466 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261436AbUK1LWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 06:22:11 -0500
To: ecki-news2004-05@lina.inka.de
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> (message
	from Bernd Eckenfels on Sun, 28 Nov 2004 11:28:29 +0100)
Subject: Re: Problem with ioctl command TCGETS
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net>
Message-Id: <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 28 Nov 2004 12:22:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The set-get is supposed to be used for queries, too? The size of value is
> only used for the get case to describe the buffer length in that case?
> because otherwise the set-get case may require a short value in and a large
> answer structure out.

You misunderstand the motivation.  This is to get/set small compact
parameters, not huge structures or big data.  Think get/setsockopt().

Miklos
