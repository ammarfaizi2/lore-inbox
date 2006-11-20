Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966481AbWKTT2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966481AbWKTT2B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966486AbWKTT2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:28:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10916 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966481AbWKTT2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:28:00 -0500
Subject: Re: path_lookup for executable
From: Arjan van de Ven <arjan@infradead.org>
Reply-To: arjan@infradead.org
To: e m <eyubo@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY107-F203123A8A58AB4F1F8E38AABED0@phx.gbl>
References: <BAY107-F203123A8A58AB4F1F8E38AABED0@phx.gbl>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 20 Nov 2006 20:27:57 +0100
Message-Id: <1164050878.31358.608.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 19:14 +0000, e m wrote:
> Thanks for response. Is there any other way to identify if "current"  is a 
> certain program  such as java.  You cannot surely go by name (comm field of 
> task_struct). Since  It could be linked. In another word, I want to identify 
> the executing current program. Any help appreciated.

since the binary may have been removed from the disk entirely (and no
that is not a corner case, a lot of the background daemons will have
that if their "original" gets rpm-updated or similar)... what would this
mean? What do you want to use it for?



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

