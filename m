Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262260AbRENRBh>; Mon, 14 May 2001 13:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262265AbRENRB1>; Mon, 14 May 2001 13:01:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24838 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262260AbRENRBP>; Mon, 14 May 2001 13:01:15 -0400
Subject: Re: Minor numbers
To: Andries.Brouwer@cwi.nl
Date: Mon, 14 May 2001 17:57:00 +0100 (BST)
Cc: R.E.Wolff@bitwizard.nl, alan@lxorguk.ukuu.org.uk, aqchen@us.ibm.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <UTC200105141653.SAA09595.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at May 14, 2001 06:53:05 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zLeW-0000yU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That is not more common. Around us we see major:minor splits
> 8:24, 12:20, 14:18. If we want to use NFSv3 and communicate
> with all these systems we would do wise to use 32:32.

My error. 32:32 is however not interesting. The fs and stat structs
are set up to allow 32bits. 64bits is a major exercise

> 

