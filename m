Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVBSFXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVBSFXp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 00:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVBSFXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 00:23:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48317 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261632AbVBSFXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 00:23:40 -0500
Message-ID: <4216CD4D.1040600@pobox.com>
Date: Sat, 19 Feb 2005 00:23:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Cormack <justin@street-vision.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: AHCI oops
References: <200412171723.iBHHNIc10417@tench.street-vision.com>
In-Reply-To: <200412171723.iBHHNIc10417@tench.street-vision.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Cormack wrote:
> Have a new AHCI board to test and it oopses pretty quickly just with a few
> reads simultaneously.

This should be fixed now, with

ChangeSet@1.1983.1.4, 2005-01-28 22:29:02-05:00, mkrikis@yahoo.com
   [PATCH] fix an oops in ata_to_sense_error

