Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292122AbSB0RJO>; Wed, 27 Feb 2002 12:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292815AbSB0RI6>; Wed, 27 Feb 2002 12:08:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21125 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292813AbSB0RIr>;
	Wed, 27 Feb 2002 12:08:47 -0500
Date: Wed, 27 Feb 2002 09:06:27 -0800 (PST)
Message-Id: <20020227.090627.109057645.davem@redhat.com>
To: nivedita@us.ibm.com
Cc: bjorn.wesen@axis.com, linux-kernel@vger.kernel.org
Subject: Re: What is TCPRenoRecoveryFail ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OF07806F93.A3E97A6C-ON88256B6D.005BC658@boulder.ibm.com>
In-Reply-To: <OF07806F93.A3E97A6C-ON88256B6D.005BC658@boulder.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Nivedita Singhvi" <nivedita@us.ibm.com>
   Date: Wed, 27 Feb 2002 09:03:27 -0800
   
   Windows and Linux dont agree on DSACK options in some
   situations, leading to symptoms you describe sometimes..

There are no options to negotiate DSACK, SACK implies DSACK will cause
no harm.  An pre-DSACK implementation of SACK should effectively
treat the DSACKs as nops, ie. they are harmless.
