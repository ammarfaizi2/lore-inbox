Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVIMHGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVIMHGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 03:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVIMHGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 03:06:17 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:18880
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S932427AbVIMHGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 03:06:16 -0400
Date: Tue, 13 Sep 2005 03:02:04 -0400
From: Sonny Rao <sonny@burdell.org>
To: Danny ter Haar <dth@cistron.nl>
Cc: linux-kernel@vger.kernel.org, mbligh@mbligh.org
Subject: Re: 2.6.13-mm3
Message-ID: <20050913070204.GA30231@kevlar.burdell.org>
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912200914.GA13962@kevlar.burdell.org> <dg4qeg$27m$1@news.cistron.nl> <20050912220617.GA18215@kevlar.burdell.org> <dg5n7q$daf$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dg5n7q$daf$1@news.cistron.nl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 05:14:34AM +0000, Danny ter Haar wrote:
> Sonny Rao  <sonny@burdell.org> wrote:
> >Are you using jumbo frames or anything like that?
> 
> Not as far as i know.
> 
> I gave the kernel some more buffer as stated on
> http://home.cern.ch/~jes/gige/acenic.html
> 
> echo 256144 > /proc/sys/net/core/rmem_max
> echo 262144 > /proc/sys/net/core/wmem_max

Not sure if this could lead to higher order allocations -- the only
place I think it might happen is in sock_kmalloc() 

Dunno, Martin?

