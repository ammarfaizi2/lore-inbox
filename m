Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272128AbRHVVPZ>; Wed, 22 Aug 2001 17:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272123AbRHVVOy>; Wed, 22 Aug 2001 17:14:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23680 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272121AbRHVVOo>;
	Wed, 22 Aug 2001 17:14:44 -0400
Date: Wed, 22 Aug 2001 14:14:48 -0700 (PDT)
Message-Id: <20010822.141448.112623586.davem@redhat.com>
To: groudier@free.fr
Cc: gibbs@scsiguy.com, axboe@suse.de, skraw@ithnet.com,
        phillips@bonn-fries.net, linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010822223658.X932-100000@gerard>
In-Reply-To: <20010822.114620.77339267.davem@redhat.com>
	<20010822223658.X932-100000@gerard>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=big5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id HAA03046

   From: Gérard Roudier <groudier@free.fr>
   Date: Wed, 22 Aug 2001 23:07:47 +0200 (CEST)
   
   And I seem to understand that David's preferred SUN hardware only
   allows streaming when using SAC with IOMMU.:-)
   
It is true.

   And using DAC is 1 PCI cycle lost per transaction and if we are
   picky on performances ...

True.  This is why I find it mysterious when I run across a device
which does not issue SAC for addresses with only 32-bits of
significance.

Happily, most do behave this way.

Later,
David S. Miller
davem@redhat.com
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
