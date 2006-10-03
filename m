Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWJCOdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWJCOdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 10:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWJCOdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 10:33:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:55896 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932245AbWJCOdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 10:33:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WSziBSFzBrCozrSayK42MSdORWJE5dMbXEVUz5RUf2EESMf+m+GlLpYKwQ2985PsNzAI0fyZUkTUhXStifbQ2FKoiyLrF0VKHRrvNqYPfu0OPoDpdBRKQlrP1KTrx+EiMXW2eLBwpY9dwDsXdVu0dmgMVo1vxTimeGDiVFYrUpg=
Message-ID: <6bffcb0e0610030733i4696bb98n4e98e7c275f5d19c@mail.gmail.com>
Date: Tue, 3 Oct 2006 16:33:00 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-mm3
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061003001115.e898b8cb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061003001115.e898b8cb.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm3/
>

For me it's just another stable (boring :) -mm

# cat tmp/Tests\ results
GOOD aiostress Completed Successfully
GOOD bonnie Completed Successfully
GOOD dbench Completed Successfully
GOOD fs_mark Completed Successfully
GOOD fsx Completed Successfully
GOOD interbench Completed Successfully
GOOD isic Completed Successfully
GOOD reaim Completed Successfully
GOOD scrashme Completed Successfully
GOOD sleeptest Completed Successfully
GOOD stress Completed Successfully
GOOD tbench Completed Successfully
GOOD tiobench Completed Successfully

BTW. There might be something wrong with kernel log buffer
(CONFIG_LOG_BUF_SHIFT=20)

dmesg | wc -l
256

cat mm-syslog | wc -l
935

dmesg & syslog http://www.stardust.webpages.pl/files/mm/2.6.18-mm3/

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
