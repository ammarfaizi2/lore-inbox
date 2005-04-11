Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVDKQu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVDKQu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVDKQsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:48:05 -0400
Received: from mx2.mail.ru ([194.67.23.122]:19589 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261855AbVDKQqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:46:10 -0400
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Martin Waitz <tali@admingilde.org>
Subject: Re: [patch 1/2] Docbook: use custom stylesheet
Date: Mon, 11 Apr 2005 20:49:15 +0000
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050411155806.754650000@faui31y> <20050411160739.635973000@faui31y>
In-Reply-To: <20050411160739.635973000@faui31y>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504112049.15921.adobriyan@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 April 2005 15:58, Martin Waitz wrote:
> Docbook: use custom stylesheet
> 
> With the custom stylesheet, functions are rendered using ANSI-C syntax
> and xmlto is a bit quieter.

Definitely better. Still remains (anything with more than 1 argument):
==================================================================
Synopsis

int bios_param (struct scsi_device *   sdev,
                struct block_device *  bdev,
                sector_t               capacity,
                int                    params[3]);

Arguments
==================================================================
Synopsis

int queuecommand (struct scsi_cmnd *  scp,
                  void (*             done) (struct scsi_cmnd *));

Arguments
==================================================================

Nice to see [TeX mode on] -- [TeX mode off] instead of "--" after function 
name. ;-)

Second patch works.
