Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSJNIP4>; Mon, 14 Oct 2002 04:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261871AbSJNIP4>; Mon, 14 Oct 2002 04:15:56 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:58790 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261868AbSJNIPz> convert rfc822-to-8bit; Mon, 14 Oct 2002 04:15:55 -0400
Message-ID: <3DAA7E8F.36B03682@folkwang-hochschule.de>
Date: Mon, 14 Oct 2002 10:21:35 +0200
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-audio-dev@music.columbia.edu
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] latency performance of 2.4 and 2.5...
References: <3DA6C8A3.2892656@folkwang-hochschule.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

some new interesting results with 2.5.42:

http://spunk.dnsalias.org/latencytest/2.5.42/2x256.html

overall much worse, *but* greatly reduced latency peaks (max. 6 ms) as
compared to 2.5.41:

http://spunk.dnsalias.org/latencytest/2.5.41/2x256.html

here the peaks easily reach 13 ms.
i'm not really sure what to make of this....
can someone explain ?

andrew, it seems part of your mm patch was merged - is there an updated
patch around that will add the missing hunks ?

best,

jörn

-- 
Jörn Nettingsmeier     
Kurfürstenstr 49, 45138 Essen, Germany      
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)
