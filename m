Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUGVCpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUGVCpV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 22:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUGVCpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 22:45:21 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:52392 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266793AbUGVCpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 22:45:16 -0400
Subject: Re: pci_bus_lock question
From: John Rose <johnrose@austin.ibm.com>
To: Greg KH <gregkh@us.ibm.com>
Cc: Mike Wortman <wortman@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1090447841.544.7.camel@sinatra.austin.ibm.com>
References: <1090447841.544.7.camel@sinatra.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1090448467.544.10.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 21 Jul 2004 17:21:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But then, most of these violations are in __init functions.  I think I
just answered my own question :)

Thanks-
John

On Wed, 2004-07-21 at 17:10, John Rose wrote:
> Is the intended purpose of pci_bus_lock to synchronize access to _just_
> the global list of pci devices, or also to the pci_root_buses list?
> 
> If it is intended to protect the latter, I see many unfortunate places
> where it's not being used :)
> 
> Thanks-
> John

