Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281367AbRKMBFj>; Mon, 12 Nov 2001 20:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281326AbRKMBFc>; Mon, 12 Nov 2001 20:05:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59140 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281422AbRKMBEI>; Mon, 12 Nov 2001 20:04:08 -0500
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
To: jamagallon@able.es (J . A . Magallon)
Date: Tue, 13 Nov 2001 01:11:36 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20011113004303.C1531@werewolf.able.es> from "J . A . Magallon" at Nov 13, 2001 12:43:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163S6y-0007pw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -		 */
> -		return scsi_check_sense(SCpnt);
> +		return SUCCESS;
>  	default:
>  		return FAILED;
>  	}
> 
> Is really needed ?

I think so but its only for specific cases like shared busses
