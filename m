Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVFVRHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVFVRHG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVFVRBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:01:03 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:10205 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261688AbVFVQ6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:58:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lGHE2lNOCn+1bQ75s6w5pQ1m1emiyV+RmZ3mnLq0z2qGFNmecVFQkc/ciJWT2oayM4fivBBOdnEPbpiXThHEzkTXuyxFglzPdu3HqwmQ8oy0Nj0AmsUdXKVz5RvkQyYmGrkGSWW86ZnxFXm/aNsonsEMpLxixC7/3GQC5LV8npA=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: 2.6.11 amd64: raw1394 returns EINVAL
Date: Wed, 22 Jun 2005 21:04:43 +0400
User-Agent: KMail/1.7.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1119294171.7213.3.camel@bip.parateam.prv>
In-Reply-To: <1119294171.7213.3.camel@bip.parateam.prv>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506222104.43315.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 23:02, Xavier Bestel wrote:
> when using dvgrab (32bits userspace) on an amd64, the 1st write()
> syscall on /dev/raw1394 fails with -EINVAL on a 64bits kernel, whereas
> it works on a 32bits kernel.

I've filed a bug at kernel bugzilla, so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4779

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.
