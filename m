Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbTLIO6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbTLIO4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:56:23 -0500
Received: from cafe.hardrock.org ([142.179.182.80]:41887 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S265941AbTLIOzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:55:16 -0500
Date: Tue, 9 Dec 2003 07:55:03 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: computer hangs with 2.4.23 (2.4.22 works)
In-Reply-To: <Pine.GSO.4.58.0312091309090.15061@stekt37>
Message-ID: <Pine.LNX.4.51.0312090752320.31228@cafe.hardrock.org>
References: <Pine.GSO.4.58.0312091309090.15061@stekt37>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Tuukka Toivonen wrote:

> [1.] One line summary of the problem:
> Computer hangs after few hours of uptime

Hi,
You have CONFIG_IP_NF_COMPAT_IPCHAINS as a module, are you using ipchains
compatibility?

Try the patch at:
http://www.hardrock.org/kernel/current-updates/linux-2.4.23-updates.patch
and see if that makes a difference for you.  It contains the ipchains compat
oops amoung other patches.

Regards
James

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  
