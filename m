Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVHWCMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVHWCMz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 22:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVHWCMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 22:12:55 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:30582 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751325AbVHWCMz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 22:12:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LaIrLseSAo+8DGGpE94dwwzo7cE8w4nYSioSXiYHi/QN5FtM8KSW0QauuMwWym1ryWnCOGfgnJW91s9+VxcmypmcCehTpLwe8kChAxvafUrtOz4pCm2F0bhJIhGHFRRwZG75du47q9clrEs/K3mn6UF6mZjOZXda+XMaeeL3Ue8=
Message-ID: <c1e1128f050822191243332304@mail.gmail.com>
Date: Tue, 23 Aug 2005 10:12:52 +0800
From: David Teigland <dteigland@gmail.com>
Reply-To: teigland@redhat.com
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] DLM must depend on SYSFS
Cc: Patrick Caulfield <pcaulfie@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050822162047.GB9927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050822162047.GB9927@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/05, Adrian Bunk <bunk@stusta.de> wrote:
>  config DLM
>         tristate "Distributed Lock Manager (DLM)"
> +       depends on SYSFS
>         depends on IPV6 || IPV6=n
>         select IP_SCTP
>         select CONFIGFS_FS

Thanks, you added this once before but it got clobbered
by your subsequent depends on IPV6 patch.

Dave
