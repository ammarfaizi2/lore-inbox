Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbTBOOUF>; Sat, 15 Feb 2003 09:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTBOOUF>; Sat, 15 Feb 2003 09:20:05 -0500
Received: from services.cam.org ([198.73.180.252]:28962 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S262040AbTBOOUF>;
	Sat, 15 Feb 2003 09:20:05 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.61-mm1
Date: Sat, 15 Feb 2003 09:29:51 -0500
User-Agent: KMail/1.5.9
References: <20030214231356.59e2ef51.akpm@digeo.com>
In-Reply-To: <20030214231356.59e2ef51.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302150929.51856.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 15, 2003 02:13 am, Andrew Morton wrote:
>   Turns out that some parts of KDE (kmail, at least) were indeed using this
>   hint, and it triggers a nasty bug in (at least) kmail: it is reading the
>   same 128k of the file again and again and again.  It runs like a dog.
>   Ed Tomlinson upgraded his KDE/kmail version and this problem went away.

The versions of kmail involved were 3.04, which manifests the bug when switching
between folders with lots of entries (10,000+).  The kmail in kde 3.1 does not
have this problem.

Ed Tomlinson

