Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbUBKOSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUBKOSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:18:35 -0500
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:18825 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S264477AbUBKOSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:18:33 -0500
Message-ID: <402A39B2.1010207@backtobasicsmgmt.com>
Date: Wed, 11 Feb 2004 07:18:26 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: ATARAID userspace configuration tool
References: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk>	 <1076425115.23946.18.camel@leto.cs.pocnet.net>	 <40292246.2030902@backtobasicsmgmt.com>	 <1076440714.27328.8.camel@leto.cs.pocnet.net>	 <20040211013551.GB2153@kroah.com>  <4029892C.2070009@backtobasicsmgmt.com> <1076499258.5253.1.camel@leto.cs.pocnet.net>
In-Reply-To: <1076499258.5253.1.camel@leto.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:

> Aren't the disks the ATARAID is made of usually on the same controller?
> Then you only have to scan that one.

Yes, that would be a simple optimization for this case. I was 
envisioning the future tools to handle existing MD and LVM autodetection 
and that would require looking at all potential block devices.

