Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbWBAP2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbWBAP2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWBAP2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:28:33 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52382 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1161093AbWBAP2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:28:32 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Wed, 1 Feb 2006 17:28:10 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <E1F4JgR-0004m5-00@calista.inka.de>
In-Reply-To: <E1F4JgR-0004m5-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602011728.10118.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 17:14, Bernd Eckenfels wrote:
> Denis Vlasenko <vda@ilport.com.ua> wrote:
> > # mount /dev/sdc3 /.3
> > mount: you must specify the filesystem type
> 
> what happens if you actually specify the fs type?

It works.

# mount -t reiserfs /dev/sdc3 /.3
# umount /.3
# mount /dev/sdc3 /.3
mount: you must specify the filesystem type

--
vda
