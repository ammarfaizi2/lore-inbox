Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSJUT0N>; Mon, 21 Oct 2002 15:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbSJUT0N>; Mon, 21 Oct 2002 15:26:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19858 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261600AbSJUT0N>; Mon, 21 Oct 2002 15:26:13 -0400
Date: Mon, 21 Oct 2002 12:33:35 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: andy barlak <andyb@island.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi_error device offline fix
Message-ID: <20021021193335.GE1069@beaverton.ibm.com>
Mail-Followup-To: andy barlak <andyb@island.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.30.0210211036010.21364-100000@tosko.alm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0210211036010.21364-100000@tosko.alm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andy barlak [andyb@island.net] wrote:
> 
> This patch to scsi_error.c   make no improvement
> in my BusLogic 958  difficulties.  Still get these messages
> and timouts with the patch.
> 
> scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
>  error recovery: host 0 channel 0 id 1 lun 0
> .
> .
> .
> 
> -- 
> 
>  Andy Barlak

Is the patch applied correctly?

I the patch the printk is changed to "scsi:" instead of
"scsi_eh_offline_sdevs:"

-andmike
--
Michael Anderson
andmike@us.ibm.com

