Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWAWQu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWAWQu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWAWQuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:50:55 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:2704 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964805AbWAWQuy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:50:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ciba+ULx68P41l/wMdvf6BuvpMLT73EE8Z/3U4qu5vLuCxofo7AVmt6Zll20TgRkHANhbd4npjCB9a+g2tkpSC+XzbEpPWVZIstwEJY6otR9TE3zwSWkJYmfB0626cIlQxD/Bj2IveYEBTk4fl/bIHSJlwIKJ55fhje3bsPY75c=
Message-ID: <5a2cf1f60601230850rdaa86d4ha4c121ec8c4638c2@mail.gmail.com>
Date: Mon, 23 Jan 2006 17:50:53 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Jim Nance <jlnance@sdf.lonestar.org>
Subject: Re: sendfile() with 100 simultaneous 100MB files
Cc: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060122142401.GA24738@SDF.LONESTAR.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com>
	 <20060122142401.GA24738@SDF.LONESTAR.ORG>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/06, Jim Nance <jlnance@sdf.lonestar.org> wrote:
> On Fri, Jan 20, 2006 at 04:53:44PM -0500, Jon Smirl wrote:
[...]
> The fastest way to transfer 100 100M files would be to send them one at a
> time.

... assuming the bottleneck is not the end user upload network
bandwidth, which is, in the case of a big network file server with
many clients over the Internet, almost never the case.

J
