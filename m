Return-Path: <linux-kernel-owner+willy=40w.ods.org-S277982AbUKARDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S277982AbUKARDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 12:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S278852AbUKARDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:03:25 -0500
Received: from bay23-f23.bay23.hotmail.com ([64.4.22.73]:61473 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264699AbUKARDF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:03:05 -0500
X-Originating-IP: [64.90.198.61]
X-Originating-Email: [jocosby@hotmail.com]
From: "Joseph Cosby" <jocosby@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: matan@svgalib.org
Subject: Re: Call to mmap Failing in SVGALIB
Date: Mon, 01 Nov 2004 10:02:36 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY23-F23vIPNTAbAWF0001daa9@hotmail.com>
X-OriginalArrivalTime: 01 Nov 2004 17:03:00.0619 (UTC) FILETIME=[A4A2EDB0:01C4C034]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Are you using version 1.4.3 of svgalib?
>If so, please edit line 1956 of vga.c to read
>
>if ((long) GM == -1) {
>
>instead of
>
>if ((long) GM < 0) {
>
>
>And tell me if it helps. If not, please tell me (if you can) which mmap
>call fails.
>
>
>--
>Matan Ziv-Av.                         matan@svgalib.org
>

Thank you for this suggestion. When I implement this change then everything 
appears to work correctly.

Thank you for your help,
Joseph

_________________________________________________________________
Don’t just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/

