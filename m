Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269325AbSIRWSz>; Wed, 18 Sep 2002 18:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269365AbSIRWSy>; Wed, 18 Sep 2002 18:18:54 -0400
Received: from server.s8.com ([66.77.12.139]:31246 "EHLO server.s8.com")
	by vger.kernel.org with ESMTP id <S269325AbSIRWSy>;
	Wed, 18 Sep 2002 18:18:54 -0400
Subject: Re: PATCH: Support tera byte disk
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: "H. J. Lu" <hjl@lucon.org>, linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020918203247.GS13929@clusterfs.com>
References: <20020918131120.A5120@lucon.org> 
	<20020918203247.GS13929@clusterfs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Sep 2002 15:23:51 -0700
Message-Id: <1032387831.22773.27.camel@plokta.s8.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 13:32, Andreas Dilger wrote:

> There's also a limit where statfs() overflows at 16TB for 4kB block
> filesystems...  Ask me how I noticed this ;-)

Well, the whole world goes pear-shaped on ia32 with >16TB filesystems,
so statfs is the least of your worries in that case :-(

	<b
