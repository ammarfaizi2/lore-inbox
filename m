Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293721AbSCFR0W>; Wed, 6 Mar 2002 12:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293723AbSCFR0J>; Wed, 6 Mar 2002 12:26:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37642 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S293721AbSCFRZZ>; Wed, 6 Mar 2002 12:25:25 -0500
Date: Wed, 6 Mar 2002 17:25:17 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rework of /proc/stat
Message-ID: <20020306172517.B26344@flint.arm.linux.org.uk>
In-Reply-To: <3C864F07.8050806@linkvest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C864F07.8050806@linkvest.com>; from jean-eric.cuendet@linkvest.com on Wed, Mar 06, 2002 at 06:16:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 06:16:55PM +0100, Jean-Eric Cuendet wrote:
> I've made a new version of IO statistics in kstat that remove the
> previous limitations of MAX_MAJOR
> I've made tests on my machine.
> Could someone test it, please?
> Feedback welcome.

Your mailer was hungry and ate the patch (small examples):

> +
> + 
> unsigned int major;
> +    unsigned int minor;
> +
> + 
> unsigned int io;
> +    unsigned int rio;
> +    unsigned int wio;
...
> + 
> if (p == 0)
> + 
> {
> + 
>      kstat.io_stat_tbl[i] = pstat;
> + 
> }
> + 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

