Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSFYNgE>; Tue, 25 Jun 2002 09:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSFYNgD>; Tue, 25 Jun 2002 09:36:03 -0400
Received: from cwbone.bsi.com.br ([200.194.240.1]:37701 "EHLO
	cwbone.bsi.com.br") by vger.kernel.org with ESMTP
	id <S315479AbSFYNgA>; Tue, 25 Jun 2002 09:36:00 -0400
Message-ID: <3D1871B1.2000002@PolesApart.wox.org>
Date: Tue, 25 Jun 2002 10:35:45 -0300
From: "Alexandre P. Nunes" <alex@PolesApart.wox.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NVidia proprietary driver problem? Read this.
X-scanner: scanned by Inflex 1.0.9 - (http://pldaniels.com/inflex/)
Content-Type: multipart/mixed;
 boundary="------------000103050708010708060704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000103050708010708060704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'm forwarding an email i've got from nvidia. All linux users having 
problems with the NVdriver and that are able to supply the information 
Christian is asking me in this forwarded email, are encouraged to sent 
this information directly to him.


Please read the forwarded message.

Cheers,

Alexandre

--------------000103050708010708060704
Content-Type: message/rfc822;
 name="Re: NVidia + kernel panic discussion at linux kernel list."
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: NVidia + kernel panic discussion at linux kernel list."

X-Mozilla-Status2: 00000000
Return-Path: <CZander@nvidia.com>
Delivered-To: polesapart@empire.lax
Received: from cwbone.bsi.com.br (cwbone.bsi.com.br [200.194.240.1])
	by empire.lax (Postfix) with ESMTP id B8A671B654
	for <polesapart@projetos.etc.br>; Mon, 24 Jun 2002 16:44:36 -0400 (EDT)
Received: from scribtwo.escriba.com.br (BSI16-27.bsi.com.br [200.189.16.27])
	by cwbone.bsi.com.br (8.12.3/8.12.3) with ESMTP id g5OKk2R7010348
	for <polesapart@projetos.etc.br>; Mon, 24 Jun 2002 17:46:07 -0300 (BRT)
Received: (from root@localhost)
	by scribtwo.escriba.com.br (8.11.6/8.10.2) id g5OKiUh08701
	for polesapart@projetos.etc.br; Mon, 24 Jun 2002 17:44:30 -0300
Received: from scribfour.escriba.com.br (ns2.escriba.com.br [200.250.187.131])
	by scribtwo.escriba.com.br (8.11.6/8.10.2) with ESMTP id g5OKiUK08677
	for <polesapart@projetos.etc.br>; Mon, 24 Jun 2002 17:44:30 -0300
Received: from mx1.yipes.com (root@[66.227.42.2])
	by scribfour.escriba.com.br (8.11.6/8.11.0) with ESMTP id g5OKi3D00729
	for <alex@polesapart.dhs.org>; Mon, 24 Jun 2002 17:44:19 -0300
Received: from [209.213.198.25] (HELO NVVwall.nvidia.com)
  by mx1.yipes.com (CommuniGate Pro SMTP 3.5.1)
  with SMTP id 6030216; Mon, 24 Jun 2002 12:43:21 -0800
Received: by mail-sc-0.nvidia.com with Internet Mail Service (5.5.2653.19)
	id <NSBA3BRR>; Mon, 24 Jun 2002 13:40:58 -0700
Received: from goblin (dhcp-177-152.nvidia.com [172.16.177.152]) by mail-sc-0.nvidia.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id NSBA3BR3; Mon, 24 Jun 2002 13:40:53 -0700
Received: from zander by goblin with local (Exim 3.35 #1 (Debian))
	id 17MagX-0005lD-00; Mon, 24 Jun 2002 13:43:41 -0700
From: Christian Zander <CZander@nvidia.com>
Reply-To: Christian Zander <czander@nvidia.com>
To: "Alexandre P. Nunes" <alex@polesapart.dhs.org>
Cc: linux-bugs@nvidia.com
Date: Mon, 24 Jun 2002 13:43:41 -0700
Subject: Re: NVidia + kernel panic discussion at linux kernel list.
Message-ID: <20020624204341.GI10204@goblin>
References: <3D172EEA.7040504@PolesApart.dhs.org>
Mime-Version: 1.0
X-scanner: scanned by Inflex 1.0.9 - (http://pldaniels.com/inflex/)
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D172EEA.7040504@PolesApart.dhs.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux [2.4.18][i686]

On Mon, Jun 24, 2002 at 11:38:34AM -0300, Alexandre P. Nunes wrote:
>
> Someone please read the thread:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=102479554629270&w=2
> 
> Including the replies.
> 

Please provide me with the following pieces of information:

  - your system's hardware configuration
  - a list of the loaded modules
  - the kernel version
  - your current kernel's configuration file
  - the development tools used to build it (gcc, binutils, etc)
  - the shortest way to reproduce the problem
  - the exact BUG message, if possible a ksymoops decoded trace
  - any relevant log files
  - whatever else you can think of that might help

The more information you can provide, the better; I can't currently
reproduce the problem, however I have had reports from other users
experiencing it. If you know other users with this problem and have
a way to contact them, please ask them to send me these bits of
information as well. One user reported that he could not reproduce
the problem with 2.5 series kernels; I do not encourage you to use
2.5 at this point, but if you feel adventurous, it would be helpful
to know how 2.5 works for you.

Thanks,

-- 
christian zander
czander@nvidia.com

--------------000103050708010708060704--

