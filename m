Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUHYXom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUHYXom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUHYXol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:44:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23444 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266481AbUHYXnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:43:46 -0400
Date: Thu, 26 Aug 2004 00:43:45 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Paulo Marques <pmarques@grupopie.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org,
       bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
Message-ID: <20040825234345.GN21964@parcelfarce.linux.theplanet.co.uk>
References: <1093406686.412c0fde79d4f@webmail.grupopie.com> <20040825173941.GJ5414@waste.org> <412CDE9D.3090609@grupopie.com> <20040825185854.GP31237@waste.org> <412CE3ED.5000803@grupopie.com> <20040825192922.GH21964@parcelfarce.linux.theplanet.co.uk> <412D236E.3030401@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412D236E.3030401@grupopie.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 12:40:30AM +0100, Paulo Marques wrote:
> That is why I kept a big *If* in that sentence. I'm quite new to all
> this, and I'm still reading a lot of source code.
> 
> If the culprit is in fact seq_file, and seq_file can be improved in a
> way that works for everyone (not only kallsyms), then I also agree
> that is is the way to go. But hunting this down might prove that the
> problem is somewhere else. It is just too soon to draw conclusions.

readprofile(1) ought to narrow it down with that kind of timing difference...
