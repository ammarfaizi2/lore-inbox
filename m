Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVC3KQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVC3KQB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 05:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVC3KQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 05:16:01 -0500
Received: from postino3.roma1.infn.it ([141.108.26.5]:46273 "EHLO
	postino3.roma1.infn.it") by vger.kernel.org with ESMTP
	id S261835AbVC3KP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 05:15:56 -0500
Message-ID: <424A7C58.7040105@roma1.infn.it>
Date: Wed, 30 Mar 2005 12:15:52 +0200
From: Davide Rossetti <davide.rossetti@roma1.infn.it>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.1 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Delay in a tasklet.
References: <5009AD9521A8D41198EE00805F85F18F054EA085@sembo111.teknor.com>
In-Reply-To: <5009AD9521A8D41198EE00805F85F18F054EA085@sembo111.teknor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.30.0.2; VDF 6.30.0.55
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bouchard, Sebastien wrote:

>Hi,
>
>I'm in the process of writing a linux driver and I have a question in
>regards to tasklet :
>
>Is it ok to have large delay "udelay(1000);" in the tasklet?
>
>If not, what should I do? 
>
>Please send the answer to me personally (I'm not subscribe to the mailling
>list) :
>  
>
I'd be interested in the answer as well. I have a driver which does 
udelay(100), so no 1000 but anyway, and of course I end up having the 
X86_64 kernel happily crying. I'm moving to a little state-machine to 
allow for a multi-pass approach instead of busy-polling..
regards

