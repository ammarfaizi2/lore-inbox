Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286194AbRLTHmV>; Thu, 20 Dec 2001 02:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286195AbRLTHmK>; Thu, 20 Dec 2001 02:42:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18052 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286194AbRLTHl6>;
	Thu, 20 Dec 2001 02:41:58 -0500
Date: Wed, 19 Dec 2001 23:40:20 -0800 (PST)
Message-Id: <20011219.234020.98861143.davem@redhat.com>
To: stevie@qrpff.net
Cc: Mika.Liljeberg@welho.com, kuznet@ms2.inr.ac.ru, Mika.Liljeberg@nokia.com,
        linux-kernel@vger.kernel.org, sarolaht@cs.helsinki.fi
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20011220022218.01dc2258@whisper.qrpff.net>
In-Reply-To: <3C1FA558.E889A00D@welho.com>
	<20011218.122813.63057831.davem@redhat.com>
	<5.1.0.14.2.20011220022218.01dc2258@whisper.qrpff.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stevie O <stevie@qrpff.net>
   Date: Thu, 20 Dec 2001 02:31:44 -0500
   
   The moral of the story:
   RISC cpus abhor unaligned accesses.

They should trap on it or handle it, silent "garbage" is really not
nice behavior.
