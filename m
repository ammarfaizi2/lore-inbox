Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbUKBXVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbUKBXVI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbUKBXVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:21:06 -0500
Received: from smtp-out.hotpop.com ([38.113.3.71]:51330 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262973AbUKBXTP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:19:15 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
Date: Wed, 3 Nov 2004 07:19:04 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org,
       geert@linux-m68k.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
References: <Pine.LNX.4.10.10411022257010.5391-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10411022257010.5391-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411030719.06138.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 06:57, Mark Fortescue wrote:
> Will this work for a kernel Panic ?
>

Probably not, unless the 'Panic' tells fbcon to release the console and 
tells promcon to take over the console again.  That in itself is problematic
as fbcon cannot be safely unloaded yet.

Tony


