Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbTCGBM4>; Thu, 6 Mar 2003 20:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbTCGBM4>; Thu, 6 Mar 2003 20:12:56 -0500
Received: from SPARCLINUX.MIT.EDU ([18.248.2.241]:13326 "EHLO
	sparclinux.mit.edu") by vger.kernel.org with ESMTP
	id <S261319AbTCGBMy>; Thu, 6 Mar 2003 20:12:54 -0500
Date: Thu, 6 Mar 2003 20:09:46 -0500
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi_error fix
Message-ID: <20030307010946.GA18991@osinvestor.com>
References: <UTC200303062337.h26Nbv714178.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200303062337.h26Nbv714178.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
From: rob@osinvestor.com (Rob Radez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 12:37:57AM +0100, Andries.Brouwer@cwi.nl wrote:
> Below:
> scsi_error.c: apart from similar trivialities the only change:
> 
>     If a command fails (e.g. because it belongs to a newer
>     SCSI version than the device), it is fed to
>     scsi_decide_disposition(). That routine must return
>     SUCCESS, unless the error handler should be invoked.
[snip patch]

This patch gets me booting again.

Regards,
Rob Radez
