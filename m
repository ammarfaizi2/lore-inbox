Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVGDUsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVGDUsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 16:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVGDUsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 16:48:36 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:1083 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261662AbVGDUsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 16:48:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pIojOfQ9W0YbM7/H/qVI58RYV8JubjLttfkkyR+JF9pmpKIsmGtGp3jE1zOurLkym5p+of1pJ9QCuq2DIjjC2HaSpZGIcLNHXdxyrZmlwS5IGxssBH2axFELSuis2S/D7y10cZedpVzzhKNR3A25P6hdbWTvk+RWUyxFLmYU/dU=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Frank van Maarseveen <frankvm@frankvm.com>
Subject: Re: 2.6.12-rc6 mm->total_vm accounting imbalance?
Date: Tue, 5 Jul 2005 00:54:57 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050701141320.GA6692@janus>
In-Reply-To: <20050701141320.GA6692@janus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507050054.57779.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 July 2005 18:13, Frank van Maarseveen wrote:
> It seems that mm->vm_total is decreased too many times and wraps below
> zero:

> VmSize: 4294966376 kB			<==

> VmData: 4294960304 kB			<==

I've filed a bug at kernel bugzilla so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4842

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.
