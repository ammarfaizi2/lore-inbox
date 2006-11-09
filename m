Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWKILUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWKILUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 06:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932809AbWKILUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 06:20:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:25445 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932806AbWKILUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 06:20:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PI+/650uZoHS3+eUxwFwbNN8Kf7suNgbNPzTMriyQuj74jKFMJvHUH3rH5rtJ1bGlCf5K+ePDj5Tm+ZAsV+QzH0cXiqdmL4bHMbvyavMitwApAJsyD67L+fqWfPeBGqgpMpdVeAjcUfK7/NL6g2grEDEdcvRDGW8D5haKnnJ584=
Message-ID: <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>
Date: Thu, 9 Nov 2006 12:20:18 +0100
From: "Jiri Slaby" <jirislaby@gmail.com>
To: Jano <jasieczek@gmail.com>
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/06, Jano <jasieczek@gmail.com> wrote:
> On 8 Lis, 22:50, Jiri Slaby <jirislaby@gmail.com> wrote:
>
> >
> > Which ATA do you use (the prod or experimental)? Post a .config.
> >
>
> .config has been attached. I hope it contains an answer to your
> question, because otherwise I wouldn't know where to search for this
> information.

Aah, sorry for the question, you use 2.6.18.1 and there is no such option yet.

Despite you have ide-generic built-in and other drivers have as a
module and you don't use initrd. If I was you, I'll try to disable
ide-generic and choose your ide chipset as built-in in
ATA/ATAPI/MFM/RLL support under Device drivers.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
