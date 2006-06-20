Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWFTVZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWFTVZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWFTVZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:25:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58312 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751188AbWFTVZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:25:11 -0400
Date: Tue, 20 Jun 2006 22:25:11 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [RFC] [patch 0/6] [Network namespace] introduction
Message-ID: <20060620212511.GW27946@ftp.linux.org.uk>
References: <20060609210202.215291000@localhost.localdomain> <20060618184734.GB27946@ftp.linux.org.uk> <449866E7.4050508@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449866E7.4050508@fr.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 11:21:43PM +0200, Daniel Lezcano wrote:
> Al Viro wrote:
> >On Fri, Jun 09, 2006 at 11:02:02PM +0200, dlezcano@fr.ibm.com wrote:
> >- renaming an interface in one "namespace" affects everyone.
> 
> Exact. If we ensure the interface can't be renamed if used in different 
> namespace, is it really a problem ?

You _still_ have a single namespace; look in /sys/class/net and you'll see.
