Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264572AbUEDStG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264572AbUEDStG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 14:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264573AbUEDStG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 14:49:06 -0400
Received: from [195.23.16.24] ([195.23.16.24]:13215 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264572AbUEDStE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 14:49:04 -0400
Message-ID: <4097E4DD.6090904@grupopie.com>
Date: Tue, 04 May 2004 19:45:49 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Libor Vanek <libor@conet.cz>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
References: <20040503000004.GA26707@Loki> <Pine.LNX.4.53.0405030852220.10896@chaos> <20040503150606.GB6411@Loki> <Pine.LNX.4.53.0405032020320.12217@chaos> <20040504011957.GA20676@Loki>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.25.0.3; VDF: 6.25.0.47; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Libor Vanek wrote:

> Using kernel module:
> - user space process wants to change some file which is in "snapshoted" dir
> - my module catches this request, holds it, creates copy of original file and allows original request to proceed


Did you take a look at LVM snapshots?

http://tldp.org/HOWTO/LVM-HOWTO/snapshotintro.html

Maybe your problem is already solved...

Anyway, you really shouldn't worry about the time it takes to make a context 
switch when you want to copy a file on modify ;)

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

