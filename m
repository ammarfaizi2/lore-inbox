Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbTLZTKB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 14:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbTLZTKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 14:10:00 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:51625 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265214AbTLZTJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 14:09:59 -0500
Date: Fri, 26 Dec 2003 20:09:57 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oopses on 2.6.0
Message-ID: <20031226190957.GA1499@louise.pinerecords.com>
References: <20031226173134.GA14038@home.woodlands>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226173134.GA14038@home.woodlands>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-26 2003, Fri, 23:01 +0530
Apurva Mehta <apurva@gmx.net> wrote:

> I have attached the corresponding Ksymoops outputs as well although
> I have heard that they are not relevant on 2.6 anymore. 
> 
> Also, I have been using the 2.6 line since test1. I have got these
> errors while using the Nvidia driver. I must mention, however, that I
> have been using this same driver since test1 (4496).

...

> EIP:    0060:[<c0124338>]    Tainted: PF 

...

You need to reproduce the oops with an untainted kernel
if you expect lkml people to look into the problem.

-- 
Tomas Szepe <szepe@pinerecords.com>
