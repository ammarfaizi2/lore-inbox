Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVDTDmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVDTDmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 23:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVDTDmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 23:42:05 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:53190 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S261319AbVDTDmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 23:42:02 -0400
X-AntiVirus: PTMail-AV 0.3.83
Message-ID: <4265CF91.5070008@vgertech.com>
Date: Wed, 20 Apr 2005 04:42:09 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: Yann Dupont <Yann.Dupont@univ-nantes.fr>, linux-kernel@vger.kernel.org
Subject: Re: E1000 - page allocation failure - saga continues :(
References: <20050414214828.GB9591@mail.muni.cz> <4263A3B7.6010702@univ-nantes.fr> <20050418122202.GE26030@mail.muni.cz> <4264B202.9080304@univ-nantes.fr> <20050419080424.GA28153@mail.muni.cz>
In-Reply-To: <20050419080424.GA28153@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:
> On Tue, Apr 19, 2005 at 09:23:46AM +0200, Yann Dupont wrote:
> 
>>Do you have turned NAPI on ??? I tried without it off on e1000 and ...
>>surprise !
>>Don't have any messages since 12H now (usually I got those in less than 1H)
> 
> 
> I have NAPI on. I tried to turn it off but my test failed, I can see allocation
> failure again.
> 

Not sure if this was already sugested, but here it is anyway:
echo "vm.min_free_kbytes=16384" >> /etc/sysctl.conf

Regards,
Nuno Silva

