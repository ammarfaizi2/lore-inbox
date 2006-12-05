Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968689AbWLEUjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968689AbWLEUjI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968686AbWLEUjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:39:07 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:41754 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968687AbWLEUjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:39:05 -0500
Message-ID: <4575D8E2.3070708@us.ibm.com>
Date: Tue, 05 Dec 2006 12:38:58 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: Re: [PATCH] aic94xx: Don't call pci_map_sg for already-mapped	scatterlists
References: <4555206C.8010909@us.ibm.com> <1165338091.2785.8.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1165338091.2785.8.camel@mulgrave.il.steeleye.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

> Rather than introduce an extra flag, I think we can key of the protocol
> flag:  libata is the only thing that initiates STP tasks.  How does this
> look?

ACK.

--D
