Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTJMWjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 18:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTJMWjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 18:39:15 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:31376 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262072AbTJMWjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 18:39:13 -0400
Date: Tue, 14 Oct 2003 00:39:11 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031013223911.GB14152@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031013140858.GU1107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013140858.GU1107@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Jens Axboe wrote:

> Forward ported and tested today (with the dummy ext3 patch included),
> works for me. Some todo's left, but I thought I'd send it out to gauge
> interest. TODO:
> 
> - Detect write cache setting and only issue SYNC_CACHE if write cache is
>   enabled (not a biggy, all drives ship with it enabled)

Yup, and I disable it on all drives at boot time at the latest.

Is there a status document that lists

- what SCSI drivers support write barriers
  (I'm interested in sym53c8xx_2 if that matters)

- what IDE drivers support write barriers
  (VIA for AMD and Intel for PII/PIII/P4 chip sets here)

- what file systems know how to utilize write barriers (other than
  reiserfs ;-) - what does "dummy ext3 patch" mean?
