Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264700AbTFQMHC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 08:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbTFQMHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 08:07:02 -0400
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:63380 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S264700AbTFQMG7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 08:06:59 -0400
Message-ID: <3EEF07B0.4070509@stesmi.com>
Date: Tue, 17 Jun 2003 14:21:04 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Collen <collen@hermanjordan.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: trying to use a 2.4.18 module in 2.5.71
References: <5.2.0.9.0.20030617140233.00b8bd70@pop.kennisnet.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.2(snapshot 20021217) (K-7.stesmi.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Collen wrote:
> g'day just wandering if some one can help me out here...
> 
> i'm trying to use a module from a 2.4.18 kernel
> it's for my promise fasttrack s150 tx4 sata cart..
> 
> now i updated to kernel 2.5.71 and installed the module init tools
> copyed the ft3xx.o from 2.4.18 to 2.5.71, made a new initrd
> 
> but it keeps bugging around, i get a "invalid module format"
> 
> i built-in all the loadable module support options (incl. module version 
> support)
> 
> but i can't get the module loaded..
> annyone anny idea ??

Usually the fact that it's for 2.4.18 should ring a bell.

You can't use modules across versions and definately not across minors.

// Stefan

