Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268844AbUIMSmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268844AbUIMSmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268849AbUIMSms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:42:48 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:19928 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S268844AbUIMSm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:42:27 -0400
Date: Mon, 13 Sep 2004 20:40:49 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Andre Eisenbach <andre@eisenbach.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7-mm1] Firewire sbp2 problem
Message-ID: <20040913184046.GA9947@bogon.ms20.nix>
References: <200406210125.23577.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406210125.23577.andre@eisenbach.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 01:25:23AM -0700, Andre Eisenbach wrote:
> Hey there! 
>  
>  I have a firewire hard drive which I have previously used with an earlier 
> kernel. However, after a recent OS reinstall, I cannot access the drive 
> anymore. 
>  
>  Here is the related dmsg output: 
>  
> ieee1394: raw1394: /dev/raw1394 device initialized 
>  ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000bcd009e53243d] 
>  ieee1394: Error parsing configrom for node 0-01:1023 
>  ieee1394: The root node is not cycle master capable; selecting a new root 
> node and resetting... 
>  ieee1394: Error parsing configrom for node 0-00:1023 
>  ieee1394: Node changed: 0-00:1023 -> 0-01:1023 
>  sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
> 
>  Note that there is no further report from sbp2. Nothing happens. 
>  
>  I'm using kernel 2.6.7-mm1. 
Same here with 2.6.9-rc1-bk16 on a 12" pbook.
 -- Guido
