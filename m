Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTLYOf3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 09:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbTLYOf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 09:35:29 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:50417 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S264311AbTLYOfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 09:35:22 -0500
Message-ID: <3FEAF5A3.2090307@wmich.edu>
Date: Thu, 25 Dec 2003 09:35:15 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
CC: LINUX KERNEL MAILING LIST <linux-kernel@vger.kernel.org>
Subject: Re: IDE performance drop between 2.4.23 and 2.6.0
References: <3FEAECA4.6030201@wanadoo.es>
In-Reply-To: <3FEAECA4.6030201@wanadoo.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps a dmesg output can provide some commanility with other people 
seeing a loss? Maybe some side by side's of 2.4 performance tests?

Also, you're not nicing any of the tests from 0, right?



Luis Miguel García wrote:
> Hello:
> 
> Any of you knows how to look at this results? They still seems very low 
> for me. It's an AMD Athlon 2500+. Hard Disc Seagate Barracuda ATA V. 
> Nforce-2 motherboard.
> 
> kernel 2.6.0-test11
> 
> Any tip? Or is this correct?
> 
> bonnie++
> 
> Version  1.03       ------Sequential Output------ --Sequential Input- 
> --Random-
>                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
> --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  
> /sec %CP
> txiki            2G 21270  87 32856  11 10533   3 10962  51 28744   5 
> 157.0   0
>                    ------Sequential Create------ --------Random 
> Create--------
>                    -Create-- --Read--- -Delete-- -Create-- --Read--- 
> -Delete--
>              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  
> /sec %CP
>                 16 21675  96 +++++ +++ 23523 100 23700  99 +++++ +++ 
> 13062  61
> txiki,2G,21270,87,32856,11,10533,3,10962,51,28744,5,157.0,0,16,21675,96,+++++,++ 
> 
> +,23523,100,23700,99,+++++,+++,13062,61
> bash-2.05b$


