Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBHHgC>; Thu, 8 Feb 2001 02:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbRBHHfw>; Thu, 8 Feb 2001 02:35:52 -0500
Received: from [202.212.27.180] ([202.212.27.180]:22023 "HELO antiopikon")
	by vger.kernel.org with SMTP id <S129033AbRBHHfr>;
	Thu, 8 Feb 2001 02:35:47 -0500
Date: Thu, 8 Feb 2001 16:37:34 +0900
From: Augustin Vidovic <vido@ldh.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eepro100.c, kernel 2.4.1
Message-ID: <20010208163734.A18916@ldh.org>
Reply-To: vido@ldh.org
In-Reply-To: <20010208145355.A18627@ldh.org> <200102080723.f187N1v17541@moisil.dev.hydraweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102080723.f187N1v17541@moisil.dev.hydraweb.com>; from ionut@moisil.cs.columbia.edu on Wed, Feb 07, 2001 at 11:23:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 11:23:01PM -0800, Ion Badulescu wrote:
> Intel's documentation states that the bug does NOT exist if the
> bits 0 and 1 in eeprom[3] are 1. Thus, the workaround is correct,
> the printk is wrong.

I wonder if it's not Intel's documentation which is wrong : it seems
that the bug showed up also with the network cards used in my boxes,
and the patch I proposed seemed to fix that problem.

-- 
Augustin Vidovic                   http://www.vidovic.org/augustin/
"Nous sommes tous quelque chose de naissance, musicien ou assassin,
 mais il faut apprendre le maniement de la harpe ou du couteau."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
