Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVDLMDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVDLMDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVDLLby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:31:54 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:322 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262329AbVDLLBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:01:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MzKpv8RSfplg6Vdq6aSVMoLoelC56VA4CqDeEGs0A32RcdtEoYeFfnZrYEmRO9HNfsx6TLTsoj51nzLEKfK5MRQuEFpK+MsJ5nzSzCQKCTB3w5r2vVvLHJ2+WkuvxCoo2a13zUN09DV6kvnJxbc/LqFYgVdxa6Sap05h8ThA4rU=
Message-ID: <425BAA92.7070209@gmail.com>
Date: Tue, 12 Apr 2005 20:01:38 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
Cc: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 00/04] scsi: scsi_request_fn() reimplementation
References: <20050412103128.69172FEB@htj.dyndns.org>
In-Reply-To: <20050412103128.69172FEB@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
>  Hello, guys.
> 
>  This patchset reimplements scsi_request_fn().  All prep's are moved
> into prep_fn and all state checking/issueing are moved into
> scsi_reqfn.  prep_fn() only terminates/defers unpreparable requests
> and all requests are terminated through scsi midlayer.
> 

  This patchset assumes that previous patchsets 'timer updates' and 
'clear REQ_SPECIAL/REQ_SOFTBARRIER usages' are applied.

  Thanks.

-- 
tejun

