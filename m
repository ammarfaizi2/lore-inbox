Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUH3SvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUH3SvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUH3S1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:27:31 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:579 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268803AbUH3ST7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:19:59 -0400
Date: Mon, 30 Aug 2004 20:21:41 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       mpm@selenic.com, linux-kernel@vger.kernel.org, bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
Message-ID: <20040830182141.GB8990@mars.ravnborg.org>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk, mpm@selenic.com,
	linux-kernel@vger.kernel.org, bcasavan@sgi.com
References: <1093406686.412c0fde79d4f@webmail.grupopie.com> <20040825173941.GJ5414@waste.org> <412CDE9D.3090609@grupopie.com> <20040825185854.GP31237@waste.org> <412CE3ED.5000803@grupopie.com> <20040825192922.GH21964@parcelfarce.linux.theplanet.co.uk> <412D236E.3030401@grupopie.com> <20040825234345.GN21964@parcelfarce.linux.theplanet.co.uk> <20040826025904.02bf4c0e.akpm@osdl.org> <412DBAD9.6020303@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412DBAD9.6020303@grupopie.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 11:26:33AM +0100, Paulo Marques wrote:
> If there is a way to know at compile time the exported symbols, then 
> scripts/kallsyms might generate a bitmap along with all the other data 
> it generates so that checking is_exported would become O(1).

If there exist a symbol named __ksymtab_{symbol} then you know it is exported.

	Sam
