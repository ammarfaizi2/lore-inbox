Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVDRMkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVDRMkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVDRMkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:40:25 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:19687 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262059AbVDRMkT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:40:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tevxK62SP/9y+wfg/7PRque5NCsBsvpPXQ67Xz5CyA+Y6K5YtB8hLvAs4ezvtESbmwOUCp0pdn9mCuUUqJJGgiVTSEyjx5phHp9nPXbCwYYPHgpOM4aUwxRrEsUhSxKJa4bCHq+FNjQQT7k2fQZ4jdlG9Y5K8xp6x/goFOJwj1M=
Message-ID: <68b6a2bc050418054017ae73b8@mail.gmail.com>
Date: Mon, 18 Apr 2005 15:40:16 +0300
From: Ehud Shabtai <eshabtai.lkml@gmail.com>
Reply-To: Ehud Shabtai <eshabtai.lkml@gmail.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: Need some help to debug a freeze on 2.6.11
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Alexander Nyberg <alexn@dsv.su.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200504181527.02112.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <68b6a2bc050418000619a552de@mail.gmail.com>
	 <Pine.LNX.4.62.0504181220090.2522@dragon.hyggekrogen.localhost>
	 <68b6a2bc05041803561621ddd6@mail.gmail.com>
	 <200504181527.02112.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/05, Denis Vlasenko <vda@ilport.com.ua> wrote:
> On Monday 18 April 2005 13:56, Ehud Shabtai wrote:
> > As an alternative, can I configure netconsole for my ethernet port and
> > only really connect it, after I get the freeze?
> 
> UDP packets will be long gone at the time you plug cable in.

I will probably lose the oops message, but won't I be able to use
SysRq to get some hints about the problem?

Anyway, which SysRq keys should help me debug the problem?
