Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVDUKZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVDUKZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 06:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVDUKZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 06:25:43 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:58414 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261273AbVDUKZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 06:25:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AQrwddxeZrfpCLyGz15hoP8nacPuG/XWD8iyNQ7pBxosabc4acFmaJ3vXITNlRekgKUqEG0+LVjnCBZRj8Kc/fjR8uK+3iH2GydtTrWXOs1MP7UI3N1noKxLoNHFK2q0as/PEpMTX/Tk6hkPKrLANE38UZ+uzlGEw6sc3fMwfxI=
Message-ID: <40f323d005042103253bf924f2@mail.gmail.com>
Date: Thu, 21 Apr 2005 12:25:38 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/net/hamradio/baycom_epp.c: cleanups
Cc: sailer@ife.ee.ethz.ch, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       netdev@oss.sgi.com
In-Reply-To: <20050420165344.GO5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050420165344.GO5489@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/05, Adrian Bunk <bunk@stusta.de> wrote:
> The times when tricky goto's produced better codes are long gone.
> 
> This patch should express the same in a better way, please check whether
> I made any mistake.
> 

By the way, it solves compile errors with gcc-4:
a lot of
drivers/net/hamradio/baycom_epp.c:690: error: jump into statement expression

regards,

Benoit
