Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbVIXGla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbVIXGla (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 02:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVIXGla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 02:41:30 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:17166 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751444AbVIXGla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 02:41:30 -0400
To: viro@ftp.linux.org.uk
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20050924060913.GK7992@ftp.linux.org.uk> (message from Al Viro on
	Sat, 24 Sep 2005 07:09:13 +0100)
Subject: Re: [PATCH] open: O_DIRECTORY and O_CREAT together should fail
References: <E1EIonQ-0006Ts-00@dorka.pomaz.szeredi.hu> <20050923122834.659966c4.akpm@osdl.org> <E1EJ2xC-0007SZ-00@dorka.pomaz.szeredi.hu> <20050924060913.GK7992@ftp.linux.org.uk>
Message-Id: <E1EJ3ib-0007V7-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 24 Sep 2005 08:41:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well yes.  But I don't think anybody is using it, and if so they are
> > clearly breaking the rules in man open(2):
> 
> Be liberal in what you accept and all such...  Everything else aside,
> why bother?

To conform to well defined semantics?

It just bathers me, that you can get a non-directory file descriptor
with O_DIRECTORY.

Miklos
