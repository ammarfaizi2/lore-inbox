Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbTBBL6d>; Sun, 2 Feb 2003 06:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbTBBL6d>; Sun, 2 Feb 2003 06:58:33 -0500
Received: from boden.synopsys.com ([204.176.20.19]:35970 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S265205AbTBBL6c>; Sun, 2 Feb 2003 06:58:32 -0500
Date: Sun, 2 Feb 2003 13:07:52 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: futimes()?
Message-ID: <20030202120752.GK5239@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <b1htmi$9r6$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1htmi$9r6$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin, Sun, Feb 02, 2003 02:53:22 +0100:
> In the general vein of avoiding security holes by using file
> descriptors when doing repeated operations on the same filesystem
> object, I have noticed that there doesn't seem to be a way to set
> mtime using a file descriptor.  Do we need a futimes() syscall?

There is a small problem with close(). It can update mtime as well.

