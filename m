Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752997AbWKFMsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbWKFMsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbWKFMsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:48:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:57763 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752997AbWKFMsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:48:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=edauAX3MmS80twfGA59XHCP4ut3pCSRLsltrH9g8FEAeeIHp0jNUIXShEG1Xy93vqanWsrTZSDAA4KFZf8snt6MReolnvZquUIsOSaovsulIcNkkZsOYqC4ZRAG3jBv28BYvaPNNnXjTxjO7+gaHH39A9YoG2zF2LHWf9jdZ4So=
Message-ID: <454F2F1A.2040705@gmail.com>
Date: Mon, 06 Nov 2006 21:48:26 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Jean-Baptiste BUTET <ashashiwa@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20375 (SATA150 TX2plus) doesn't work with last kernels.
References: <233976e40611040503m2a4bf449k78f84b0768d1f14e@mail.gmail.com> <233976e40611052238u4dfa9bdek83c74494b7163b39@mail.gmail.com>
In-Reply-To: <233976e40611052238u4dfa9bdek83c74494b7163b39@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Baptiste BUTET wrote:
> Is there any PATA support broken in new sata_promise/libata stuff ? Is
> there any good kernel configuration in order to make it works?

Ubuntu kernel includes support for PATA ports on promise controllers but 
it isn't included in mainline kernel yet.  Proper implementation 
requires a new feature in libata which is currently being worked on. 
So, please be patient.

Thanks.

-- 
tejun
