Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWJEN5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWJEN5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWJEN5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:57:53 -0400
Received: from igw1.zrnko.cz ([81.31.45.161]:33505 "EHLO anubis.fi.muni.cz")
	by vger.kernel.org with ESMTP id S1751092AbWJEN5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:57:52 -0400
Date: Thu, 5 Oct 2006 15:59:38 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Machine reboot
Message-ID: <20061005135938.GL2923@mail.muni.cz>
References: <20061005105250.GI2923@mail.muni.cz> <9a8748490610050428kc87fd6aj9b18d6e51e64f145@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a8748490610050428kc87fd6aj9b18d6e51e64f145@mail.gmail.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 01:28:00PM +0200, Jesper Juhl wrote:
> >I'm facing troubles with machine restart. While sysrq-b restarts machine, 
> >reboot
> >command does not. Using printk I found that kernel does not hang and issues
> >reset properly but BIOS does not initiate boot sequence. Is there something
> >I could do?
> >
> You can try playing with different combinations of these options :
> 
> CONFIG_APM_ALLOW_INTS
> CONFIG_APM_REAL_MODE_POWER_OFF

I'm not using APM (as I think my board DP965LT does not support APM).

Also power off works OK (using halt cmd).

-- 
Luká¹ Hejtmánek
