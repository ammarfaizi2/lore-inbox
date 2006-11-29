Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758845AbWK2NTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758845AbWK2NTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758846AbWK2NTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:19:46 -0500
Received: from bay0-omc3-s31.bay0.hotmail.com ([65.54.246.231]:47277 "EHLO
	bay0-omc3-s31.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1758845AbWK2NTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:19:45 -0500
Message-ID: <BAY107-F330850604F413A1DA24A79CE40@phx.gbl>
X-Originating-IP: [87.81.120.187]
X-Originating-Email: [dcb314@hotmail.com]
From: "d binderman" <dcb314@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: fs/9p/mux.c(786): remark #593: variable "cb" was set but never used    
Date: Wed, 29 Nov 2006 13:19:43 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 29 Nov 2006 13:19:45.0176 (UTC) FILETIME=[09730980:01C713B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

I just tried to compile Linux kernel 2.6.18.3 with the Intel C
C compiler.

The compiler said

fs/9p/mux.c(786): remark #593: variable "cb" was set but never used

The source code is

    v9fs_mux_req_callback cb;

I have checked the source code and I agree with the compiler.
Suggest delete local variable.


Regards

David Binderman

_________________________________________________________________
Download the new Windows Live Toolbar, including Desktop search! 
http://toolbar.live.com/?mkt=en-gb

