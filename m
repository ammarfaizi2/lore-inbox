Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752895AbWKBOKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbWKBOKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbWKBOKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:10:00 -0500
Received: from brick.kernel.dk ([62.242.22.158]:41818 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1752898AbWKBOJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:09:59 -0500
Date: Thu, 2 Nov 2006 15:11:50 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/8] cciss: change number of commands per controller
Message-ID: <20061102141149.GI13555@kernel.dk>
References: <20061101215640.GC29928@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101215640.GC29928@beardog.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01 2006, Mike Miller (OS Dev) wrote:
> +	{0x3211103C, "Smart Array E200i", &SA5_access, 120},

Is it 120, or 128? And how big is the allocated command array now, with
512 commands?

-- 
Jens Axboe

