Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVAQTAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVAQTAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVAQTAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:00:36 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:61839 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262614AbVAQTAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:00:31 -0500
Date: Mon, 17 Jan 2005 14:00:28 -0500
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050117190028.GF24830@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <41EC0466.9010509@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EC0466.9010509@sun.com>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 01:31:02PM -0500, Mike Waychison wrote:
> Corner case: how do we handle the case where:
> 
> mount --make-shared /foo
> mount --bind /foo /foo/bar
> 
> A nested --bind without sharing makes sense, but doesn't when sharing is
> enabled (infinite loop).

How does this force an infinite loop?  I don't see it.

--Bruce Fields
