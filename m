Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270370AbTG1RmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 13:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270373AbTG1RmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 13:42:18 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:44502 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S270370AbTG1RmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 13:42:17 -0400
Date: Mon, 28 Jul 2003 19:57:30 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: hdparm IDE sleep mode
Message-ID: <20030728175730.GA22946@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030728160412.98F59372@mendocino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728160412.98F59372@mendocino>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Johannes Ahlmann wrote:

> "-Y
>  Force  an  IDE  drive to immediately enter the lowest power con-
>  sumption sleep mode, causing it to shut down completely.  A hard
>  or soft reset is required before the drive can be accessed again
>  (the Linux IDE driver will automatically handle issuing a  reset
>  if/when  needed)."
> 
> but when i put my hdd in "sleep mode" (not suspend, that works fine) it 
> shuts dowm properly but can not be woken up again... when shutting down the 
> system, it hangs waiting for the hdds to come up again, but they never do...
> 
> i'm using kernel 2.4.20, IDE drives on a debian testing system.
> any suggestions why the ide driver does not soft-reset the drives as 
> implied in the hdparm man-page?

Is "never" longer than two minutes? How long have you waited? Does
2.4.21 work?

-- 
Matthias Andree
