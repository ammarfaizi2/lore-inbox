Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWEUPa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWEUPa0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 11:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWEUPa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 11:30:26 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:5539 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964887AbWEUPaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 11:30:25 -0400
Date: Sun, 21 May 2006 11:30:23 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Valdis.Kletnieks@vt.edu
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm2
In-Reply-To: <200605210538.k4L5ccJ1001005@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.64.0605211128060.16592@d.namei>
References: <20060520054103.46a6edb5.akpm@osdl.org>
 <200605210428.k4L4S0nv013532@turing-police.cc.vt.edu>           
 <Pine.LNX.4.64.0605210119060.25962@d.namei> <200605210538.k4L5ccJ1001005@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 May 2006, Valdis.Kletnieks@vt.edu wrote:

> On Sun, 21 May 2006 01:19:20 EDT, James Morris said:
> > On Sun, 21 May 2006, Valdis.Kletnieks@vt.edu wrote:
> 
> > > Was it *really* intended that SELINUX not be selectable if NETWORK_SECMARK
> > > isn't present?
> > 
> > Yes, it's required for SELinux.
> 
> Could stand a SELECT instead, then?

I think there are times when you need a SELECT, like when you need a 
specific set of crypto algorithms for something to work, but this is a 
distinct core requirement of SELinux, and too many SELECTs makes the 
configuration system unweildy.


- James
-- 
James Morris
<jmorris@namei.org>
