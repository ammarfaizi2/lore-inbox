Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTLYLhQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 06:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTLYLhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 06:37:16 -0500
Received: from smtp04.ya.com ([62.151.11.162]:62348 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S264296AbTLYLhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 06:37:14 -0500
Message-ID: <3FEAECA4.6030201@wanadoo.es>
Date: Thu, 25 Dec 2003 14:56:52 +0100
From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LINUX KERNEL MAILING LIST <linux-kernel@vger.kernel.org>
Subject: RE: IDE performance drop between 2.4.23 and 2.6.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

Any of you knows how to look at this results? They still seems very low 
for me. It's an AMD Athlon 2500+. Hard Disc Seagate Barracuda ATA V. 
Nforce-2 motherboard.

kernel 2.6.0-test11

Any tip? Or is this correct?

bonnie++

Version  1.03       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  
/sec %CP
txiki            2G 21270  87 32856  11 10533   3 10962  51 28744   5 
157.0   0
                    ------Sequential Create------ --------Random 
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  
/sec %CP
                 16 21675  96 +++++ +++ 23523 100 23700  99 +++++ +++ 
13062  61
txiki,2G,21270,87,32856,11,10533,3,10962,51,28744,5,157.0,0,16,21675,96,+++++,++
+,23523,100,23700,99,+++++,+++,13062,61
bash-2.05b$
