Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSJUUkd>; Mon, 21 Oct 2002 16:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSJUUkc>; Mon, 21 Oct 2002 16:40:32 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:37843 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261615AbSJUUjv> convert rfc822-to-8bit; Mon, 21 Oct 2002 16:39:51 -0400
Message-ID: <3DB46781.D4245373@folkwang-hochschule.de>
Date: Mon, 21 Oct 2002 22:45:53 +0200
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: trivial netfilter compile problem in 2.5.4[34]-mm2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi *!


in order to compile 2.5.4[34], i had to add #include
<linux/netfilter_ipv4> to net/ipv4/raw.c, since it choked on
NF_IP_LOCAL_OUT being undefined in line 297.

since i've had this problem for two kernel releases now, i thought i'd
bring this to your attention.

regards,

jörn

(please cc: me on followups, the archive i'm using to read lkml lags
badly. thx.)

-- 
Jörn Nettingsmeier     
Kurfürstenstr 49, 45138 Essen, Germany      
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)
