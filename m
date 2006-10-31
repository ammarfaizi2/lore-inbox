Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422960AbWJaIKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422960AbWJaIKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422961AbWJaIKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:10:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:5351 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422960AbWJaIKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:10:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=mw+d8HhmvCDQsW0f0Zk3JSeA5d7JMiIiMtvkdPUFppFIpTTLBzec7/GeaiUe2Rw4eGku0YbVcaHJ02PHzjeYND8Mgt37q/hvVcnOKmDFI3R86z7EsWS+uavg7qQe460Akm5LXyCMD1ilkb7VcV1Ee1ZGQPbnF1nVGHJCTwm665E=
Message-ID: <45470513.4070507@innova-card.com>
Date: Tue, 31 Oct 2006 09:10:59 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: Franck <vagabon.xyz@gmail.com>, Miguel Ojeda <maxextreme@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
References: <20061013023218.31362830.maxextreme@gmail.com>	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>	 <453CE85B.2080702@innova-card.com>	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>	 <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>	 <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com> <653402b90610271325l1effa77eq179ca1bda135445@mail.gmail.com> <4545C52A.5010105@innova-card.com> <4545FCB1.8030900@grupopie.com>
In-Reply-To: <4545FCB1.8030900@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:
> Franck Bui-Huu wrote:
>> Miguel Ojeda wrote:
>>> [...]
>>> Anyway, an animation of 10 Hz wouldn't be fine at this
>>> kind of LCDs, so it is pointless which the refresh rate of the driver
>>> is, as it is not useful to display images as fast as the driver
>>> refresh the LCD.
>>
>> An application might want to display quickly a set of images, not for
>> doing animations but rather displaying 'fake' greyscale images.
> 
> To do "fake" greyscale you would need to synchronize with the actual
> refresh of the controller or you will have very ugly aliasing artifacts.
> 
> Since there is no hardware interface to know when the controller is
> refreshing, I don't think this is one viable usage scenario.
> 

eh ?? Did you read my email before ? That was the point I was trying
to raise... and starting the refresh stuff _only_ when the device is
mmaped seems to me a good trade off.

Aynywas it seems that the discusion about the design is closed and
won't lead to interesting things...

bye
		Franck
