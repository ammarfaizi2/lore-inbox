Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTJFHRi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 03:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTJFHRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 03:17:38 -0400
Received: from cafe.hardrock.org ([142.179.182.80]:17826 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S262192AbTJFHRg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 03:17:36 -0400
Date: Mon, 6 Oct 2003 01:17:29 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: Andrew Zabolotny <zap@homelink.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: A bug (and a fix) in usbserial.c, kernel 2.4.22
In-Reply-To: <20031004022728.0ff068e1.zap@homelink.ru>
Message-ID: <Pine.LNX.4.44.0310060115160.14664-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Oct 2003, Andrew Zabolotny wrote:

> oops, sorry, I was a little wrong. Line 1408 shouldn't be removed but
> rather moved before the line that sets port->tty to NULL (e.g. line
> 559).

Don't know if anyone has mentioned this yet.

greg k-h has posted a patch for this some time ago and it can be found at
http://www.hardrock.org/kernel/current-updates/linux-2.4.22-usb-serial.patch


Regards
James Bourne

> --
> Greetings,
>    Andrew

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

