Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272279AbTHRQVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272454AbTHRQVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:21:40 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:61370 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S272279AbTHRQVi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:21:38 -0400
Date: Mon, 18 Aug 2003 09:13:59 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andries.Brouwer@cwi.nl
Cc: Dominik.Strasser@t-online.de, hch@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030818091359.A27575@beaverton.ibm.com>
References: <UTC200308181219.h7ICJfw14963.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200308181219.h7ICJfw14963.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Aug 18, 2003 at 02:19:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 02:19:41PM +0200, Andries.Brouwer@cwi.nl wrote:

> For example, this unfortunate discussion started with the u8 in
> ScsiLun, but this concept, introduced in 2.5.11, has been almost
> entirely removed again in 2.5.69, and today only occurs in
> scsi_debug.c. So, we can do

The scsi_debug.c code is there so we can easily test the scsi_scan.c code.

scsi_lun is still used in scsi_scan.c (but not the typedef) when
CONFIG_SCSI_REPORT_LUNS is enabled (as should be the norm).

-- Patrick Mansfield
