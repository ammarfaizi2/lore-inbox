Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbTFDT1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263976AbTFDT1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:27:36 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:3826 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S263970AbTFDT1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:27:34 -0400
Message-ID: <3EDE4A38.3050405@rackable.com>
Date: Wed, 04 Jun 2003 12:36:24 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel.A.Christian@NASA.gov
CC: John Appleby <john@dnsworld.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc7 SMP module unresolved symbols
References: <434747C01D5AC443809D5FC5405011314BEC@bobcat.unickz.com> <200306041106.01316.Daniel.A.Christian@NASA.gov>
In-Reply-To: <200306041106.01316.Daniel.A.Christian@NASA.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jun 2003 19:41:04.0216 (UTC) FILETIME=[3C25FD80:01C32AD1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Christian wrote:

>
>"make mrproper" fixes it.
>
>For the record, I think this stinks!
>
>"make mrproper" should  be an expert only utility because it does blow 
>away valuable configuration information (a painfull lesson that can 
>only be learned "the hard way", since the README neglicts to mention 
>this).  For that matter, the README makes it look like creating a 
>config from scratch (all 1500+ options) is no big deal!
>  
>

  Most developers have a std config file that they simply copy over, and 
run "make oldconfig".  This is why menuconfig, and xconfig get broken 
every few patches.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


