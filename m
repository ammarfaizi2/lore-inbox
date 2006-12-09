Return-Path: <linux-kernel-owner+w=401wt.eu-S936277AbWLIOSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936277AbWLIOSK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 09:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWLIOSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 09:18:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:47300 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936277AbWLIOSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 09:18:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=RB0dNK6tkAkVeAQIhfrwdkhbdIDvSg6xX5oJwIjJBSS+f/mtO5WRtNQ//bx2H+537iQTRu/fAwHYiDbXNJONHE+bobRhu0Oy5UQyzADPWcCDg2DZ7bZdMpaYvHuAXtX3lcV1Kpep8ohVMPyQfds1bJupbPLZg/jOsf7/8ebI3To=
Message-ID: <84144f020612090618g27ac861ka4ad693a0dee1928@mail.gmail.com>
Date: Sat, 9 Dec 2006 16:18:02 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: Re: Re: [PATCH] kcalloc: Re-order the first two out-of-order args to kcalloc().
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612090901180.14206@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612081837020.6610@localhost.localdomain>
	 <84144f020612090553n7fe309b7u54dd7f58424c4008@mail.gmail.com>
	 <84144f020612090554o571f142bt7f59db2c0dfa782f@mail.gmail.com>
	 <Pine.LNX.4.64.0612090901180.14206@localhost.localdomain>
X-Google-Sender-Auth: 3bcbeb42fc35b878
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
> normally what i would do but, in the case of that patch, there are
> five files affected, *all* of which are in totally different
> subsystems (macintosh, net, scsi, usb, sunrpc).  are you suggesting
> that up to 5 different people be CC'ed?
>
> and what about source-wide aesthetic changes that might touch dozens
> or hundreds of files?

Well, it depends. There are no fixed rules in the art of patch
feeding. FWIW, I probably would send this patch just to akpm too.
