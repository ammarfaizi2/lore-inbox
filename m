Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275773AbRI0GIJ>; Thu, 27 Sep 2001 02:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275774AbRI0GH7>; Thu, 27 Sep 2001 02:07:59 -0400
Received: from [159.226.4.246] ([159.226.4.246]:59920 "EHLO intec.iscas.ac.cn")
	by vger.kernel.org with ESMTP id <S275773AbRI0GHt>;
	Thu, 27 Sep 2001 02:07:49 -0400
Message-Id: <200109270557.NAA22817@intec.iscas.ac.cn>
Date: Thu, 27 Sep 2001 14:4:42 +0800
From: =?GB2312?Q?=CA=E6=B9=FA=C7=BF?= <guoqiang@intec.iscas.ac.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Question about ioremap and io_remap_page_range
X-mailer: FoxMail 4.0 beta 1 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id QAA32299


 Here is some rather basic questions I want ask ,any reply or comment please
 CC to my emailbox,thank you very much.
 
 When I work with kernel 2.4.2 in Intel X86 , I use 
		
     VIRT_ADDR = ioremap(BUS_ADDR); to map a section of PCI memory, and
     X_ADDR = virt_to_phys(VIRT_ADDR);

  I think in x86 platform X_ADDR should equel with BUS_ADDR, but it turns to be
 NOT, can you explain ?

  In X86 platform ,Can I use return value of ioremap() as a memory pointer?


  I use io_remap_page_range(BUS_ADDR,,) in mmap() function,but the result is 
 that the memory I map is READ ONLY from user space,when I try to write to it,
 a "do_sw_pg. bogus page(XXXXXXXX)" appears. Can you explain to me?


  I know these questions are childish,but I need the answer urgently,thanks!


 George Shu
 

ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
