Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbUBJT0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266145AbUBJT0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:26:13 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:27885 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S266131AbUBJTYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:24:41 -0500
Message-ID: <40292FF0.3030504@backtobasicsmgmt.com>
Date: Tue, 10 Feb 2004 12:24:32 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: ATARAID userspace configuration tool
References: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk>	 <1076425115.23946.18.camel@leto.cs.pocnet.net>	 <40292246.2030902@backtobasicsmgmt.com> <1076440714.27328.8.camel@leto.cs.pocnet.net>
In-Reply-To: <1076440714.27328.8.camel@leto.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:

> Right. dmpartx should run on dm-[0-9]* and md[0-9]* events (but not
> recursively of course ;)).

Oh I don't know, people have been asking for the ability to have 
partitioned MD devices for so long, I can see where someone may very 
well want to be able to have an MD device composed of three disks, 
broken up into LVM2 volumes, one of which contains an image of a Sun 
disk with a Solaris disklabel on it :-) For the little bit of extra time 
that dmpartx would spend looking for partition tables I don't think the 
recursion would be painful (unless dmpartx is unnecessarily noisy or 
something).

