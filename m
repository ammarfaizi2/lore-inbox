Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266013AbRGSUqZ>; Thu, 19 Jul 2001 16:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266044AbRGSUqQ>; Thu, 19 Jul 2001 16:46:16 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:2311 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266013AbRGSUqD>; Thu, 19 Jul 2001 16:46:03 -0400
Message-ID: <3B574689.BFCEE97@folkwang-hochschule.de>
Date: Thu, 19 Jul 2001 22:43:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: netfilter@lists.samba.org, netfilter-devel@lists.samba.org,
        nettings@folkwang-hochschule.de, christian@rubbert.de,
        linux-kernel@vger.kernel.org
Subject: Re: kernel lockup in 2.4.5-ac3 and 2.4.6-pre7 (netfilter ?)
In-Reply-To: <3B52ADC1.95012614@folkwang-hochschule.de> <3B534D06.5090405@earthlink.net> <3B56E91F.12C1AB9B@folkwang-hochschule.de> <3B56FE85.2080802@suche.org> <3B570B80.84AD8E8A@folkwang-hochschule.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

just fyi, 2.4.7-pre8 did not cure the problem.
i was able to reproduce the problem like before.
this time, i switched to the log console before locking the machine
up, and the oops is in fact identical to the one christian was
seeing.
the last line says "In interrupt handler - not syncing." which seems
to explain why no syslog messages survive.

regards,

jörn

-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://icem-www.folkwang-hochschule.de/~nettings/
http://www.linuxdj.com/audio/lad/
