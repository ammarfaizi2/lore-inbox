Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVJQCzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVJQCzV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 22:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVJQCzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 22:55:21 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:30674 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932152AbVJQCzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 22:55:20 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Re: Intel SATA combined mode quirk broken for SCSI_SATA=m
Date: Sun, 16 Oct 2005 19:55:07 -0700
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <200510161913.59622.jbarnes@virtuousgeek.org> <43531030.9000901@pobox.com>
In-Reply-To: <43531030.9000901@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510161955.07362.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, October 16, 2005 7:45 pm, Jeff Garzik wrote:
> Actually... does the attached patch fix things for you?

Yeah, this one causes the quirk to be built in as well.  I guess we get to 
choose between Kconfig ugliness (if vs. depends) and #if defined(..._MODULE) 
ugliness.  Yuck.

Jesse
