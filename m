Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVGPOcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVGPOcL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 10:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVGPOcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 10:32:11 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:34710 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261622AbVGPOcK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 10:32:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NqxoYGGWSMiNMa5FcmhiMcDRt+0VHNVPQ8sCfaYQc2ufCkA2aWoFsB+t3MB3Z0aM1Evn7u6X6WgUWJsuYyMxQqkVD+JqzK819rsAd5rzLtPCEXLfHbYM1vmzJLTwUAOD+s3rJTt1pTugGQLhnXdgRkcQsqBPUe10Jl/6c489emo=
Message-ID: <90c25f2705071607321d66a776@mail.gmail.com>
Date: Sat, 16 Jul 2005 20:02:10 +0530
From: Arvind Kalyan <base16@gmail.com>
Reply-To: Arvind Kalyan <base16@gmail.com>
To: linux-kernel@vger.kernel.org, Dhruv Matani <dhruvbird@gmail.com>
Subject: Re: NFS and fifos.
In-Reply-To: <3a9148b9050716034417d7d148@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3a9148b9050716034417d7d148@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/05, Dhruv Matani <dhruvbird@gmail.com> wrote:
> Hello,
>   I can't seem to be able to use fifos on an NFS mount. Is there any
> reason why this is disallowed, or is this is a bug? v.2.4.20.

Are both the processes (reader/writer) on the same machine? FIFOs are
local objects.

-- 
Arvind Kalyan
http://www.devforge.net/~arv
