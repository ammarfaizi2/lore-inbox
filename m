Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVBBVvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVBBVvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVBBVt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:49:58 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:8832 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262591AbVBBVsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:48:08 -0500
Date: Wed, 2 Feb 2005 16:48:03 -0500
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Ram <linuxram@us.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050202214803.GB5548@fieldses.org>
References: <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk> <20050117173213.GC24830@fieldses.org> <1106687232.3298.37.camel@localhost> <20050201232106.GA22118@fieldses.org> <1107369381.5992.73.camel@localhost> <42012DE7.4080003@sun.com> <1107376434.5992.113.camel@localhost> <42014150.9090500@sun.com> <20050202212557.GC3879@fieldses.org> <42014714.2070901@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42014714.2070901@sun.com>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 04:33:08PM -0500, Mike Waychison wrote:
> That still keeps you from using the 'build tree elsewhere' and 'mount
> - --move' approach though, as the parent mountpoint would likely be shared.

I believe it's also just the source mountpoint that's the problem, not
the destination; does that help?

--Bruce Fields
