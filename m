Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSJ1XWo>; Mon, 28 Oct 2002 18:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSJ1XWo>; Mon, 28 Oct 2002 18:22:44 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:20194 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261857AbSJ1XWn>; Mon, 28 Oct 2002 18:22:43 -0500
Date: Mon, 28 Oct 2002 15:28:57 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Hell.Surfers@cwctv.net
Cc: corryk@us.ibm.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: Rusty's Remarkably Unreliable 2.6 List
Message-ID: <20021028152857.A7803@eng2.beaverton.ibm.com>
Mail-Followup-To: Hell.Surfers@cwctv.net, corryk@us.ibm.com,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <096654513141ca2DTVMAIL7@smtp.cwctv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <096654513141ca2DTVMAIL7@smtp.cwctv.net>; from Hell.Surfers@cwctv.net on Mon, Oct 28, 2002 at 03:15:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 03:15:46PM +0100, Hell.Surfers@cwctv.net wrote:
> wasnt it said that *@us.ibm.com sent in patchs that broke every scsi device 'cept ibms...
> 
> Cheers, Dean.

The scsi multi-path patch is not in Rusty's list.

It includes modifications for the aic, qlogic, ips and 53c700 scsi host
adapter drivers, but not for all the other host adapter drivers.

The patch is not hardware specific, but it does require changes in list
traversal that are used by all (or nearly all) the scsi adapter drivers.

-- Patrick Mansfield
