Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWBHEMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWBHEMl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWBHEMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:12:41 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:26197 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932172AbWBHEMl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:12:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YEo5ltthHNSTgb12H2NPFnVxf5So1ULOTL0P4Q87Hrm4CoN0iNr85+NAOj69McMbXavxNckcVNwJAxhog7MerYyYMsKopg81rc+FwhL/Vo8a4rPifLR6uVRbklKoLSEbXtxM9EN2sFasxQSjmIlDACy7mNWzKHpgYaxsP6b/4SU=
Message-ID: <986ed62e0602072012g466b602ct1e78a778268e5710@mail.gmail.com>
Date: Tue, 7 Feb 2006 20:12:40 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
Cc: gcoady@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <200602081400.59931.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602081335.18256.kernel@kolivas.org>
	 <24niu1hrom6udfa2km18b8bagad62kjamc@4ax.com>
	 <200602081400.59931.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/06, Con Kolivas <kernel@kolivas.org> wrote:
> This is the terminal's fault. xterm et al use an algorithm to determine how
> fast your machine is and decide whether to jump scroll or smooth scroll. This
> algorithm is basically broken with the 2.6 scheduler and it decides to mostly
> smooth scroll.

Recent versions of xterm are supposed to fix this. (Skimming xterm's
changelog, I think it might have been fixed in version 201, but I'm
not completely sure.)
--
-Barry K. Nathan <barryn@pobox.com>
